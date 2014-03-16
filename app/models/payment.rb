class Payment < ActiveRecord::Base

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper

  class PaymentError < StandardError;end
  class PaypalPaymentNotFoundError < StandardError;end
  class UnsupportedPricingTier < StandardError;end
  class DoubleChargeError < PaymentError;end
  class NonExistentPaymentError < PaymentError;end
  class DoubleAgreeError < PaymentError;end
  class PaypalTokenRequiredError < PaymentError;end
  class UnsupportedPaymentMethodError < PaymentError;end

  PAYMENT_METHODS = {
    paypal: 'paypal',
    stripe: 'stripe',
    alipay: 'alipay'
  }

  PAYPAL_SUPPORTED_CURRENCIES = %w{
    EUR
    USD
  }

  attr_accessor :paypal_url, :promo_code, :alipay_url

  belongs_to :user
  has_one :gift_scholarship

  validates :amount, presence: true, numericality: true
  validates :sessions_count, presence: true
  validates_numericality_of :sessions_count, greater_than: 0, only_integer: true

  before_validation :set_amount

  def self.charged
    where(charged: true)
  end

  def self.most_recent
    order('created_at DESC').first
  end

  def self.new_default(attrs={})
    defaults = {
      sessions_count: 4
    }
    attrs = defaults.merge(attrs)
    obj = new(attrs)
    obj.set_amount
    obj
  end

  def paypal?
    payment_method == PAYMENT_METHODS[:paypal]
  end

  def stripe?
    payment_method == PAYMENT_METHODS[:stripe]
  end

  def alipay?
    payment_method == PAYMENT_METHODS[:alipay]
  end

  def request_paypal_url(success_callback_url, cancel_callback_url)
    raise NonExistentPaymentError if new_record?

    response = paypal_express_request.setup(paypal_payment_request,
                                            success_callback_url,
                                            cancel_callback_url,
                                            :no_shipping => true)

    self.paypal_url = response.redirect_uri
  end

  def request_alipay_url(notify_callback_url, return_url)
    sessions_count_text = pluralize(sessions_count, "Fluentlee session")
    amount_text = number_to_currency(amount, locale: :en)
    description = I18n.t('payments.paypal.description',
                         sessions_count: sessions_count_text,
                         amount: amount_text)

    options = {
      out_trade_no: id,
      subject:      description,
      return_url:   return_url,
      notify_url:   notify_callback_url,
      currency:     "USD"
    }

    # ALIPAY requests non-live payments be set to the smallest possible denomination
    test_amount = if !Rails.env.production?
                    if self.currency == "CNY"
                      0.06
                    else
                      0.01
                    end
                  end

    amt = test_amount || self.amount
    options = case self.currency
              when "USD"
                options.merge(total_fee: amt)
              when "CNY"
                options.merge(rmb_fee: amt)
              end

    self.alipay_url = Alipay::Service.create_forex_trade(options)
  end

  def charge
    if paypal?
      charge_paypal
    elsif stripe?
      charge_stripe
    elsif alipay?
      charge_alipay
    else
      raise UnsupportedPaymentMethodError
    end
  end

  def set_amount
    if tier = PricingTier.where('? BETWEEN min_sessions AND max_sessions',
                               sessions_count).first

      set_currency(tier)

      self.amount = (sessions_count * tier.price_per_session(self.currency)).round(2)
    else
      raise UnsupportedPricingTier
    end
  end

  def valid_paypal_payment?
    paypal_token.present? && paypal_payer_id.present?
  end

  def amount_in(currency)
    if tier = PricingTier.where('? BETWEEN min_sessions AND max_sessions',
                               sessions_count).first
      (sessions_count * tier.price_per_session(currency)).round(2)
    else
      raise UnsupportedPricingTier
    end
  end

  private
  def set_currency(tier)
    if !tier.priced_in?(currency)
      self.currency = Fluentlee::DEFAULT_CURRENCY
    end

    if stripe?
      self.currency = "USD"
    elsif paypal? && !self.currency.in?(PAYPAL_SUPPORTED_CURRENCIES)
      self.currency = "USD"
    end
  end

  def sessions_to_credit
    return if user.blank?
    bonus_sessions_count = user.payments.charged.blank? ? 1 : 0
    user.sessions_count + self.sessions_count + bonus_sessions_count
  end

  def charge_paypal
    if not valid_paypal_payment?
      raise PaypalPaymentNotFoundError
    elsif charged?
      raise DoubleChargeError if charged?
    end

    set_amount
    paypal_express_request.checkout!(paypal_token, paypal_payer_id, paypal_payment_request)

    new_sessions_count = sessions_to_credit
    if self.update_attributes(charged: true) && user.present?
      user.update_attribute(:sessions_count, new_sessions_count)
    else
      charged
    end
  end

  def charge_stripe
    begin
      set_amount
      description = if user
                      "Payment for #{user.email}"
                    elsif gift_scholarship
                      "Gift Scholarship Payment to #{gift_scholarship.to}"
                    end

      charge = Stripe::Charge.create(
        amount: (self.amount_in("USD") * 100).to_i.to_s,
        currency: "usd",
        card: self.stripe_token,
        description: description
      )

      new_sessions_count = sessions_to_credit
      if self.update_attributes(charged: true, stripe_charge_id: charge.id) && user.present?
        user.update_attribute(:sessions_count, new_sessions_count)
      else
        charged
      end
    rescue Stripe::StripeError
      false
    end
  end

  def charge_alipay
    raise DoubleChargeError if charged?

    set_amount
    new_sessions_count = sessions_to_credit
    if self.update_columns(charged: true) && user.present?
      user.update_attribute(:sessions_count, new_sessions_count)
    end
  end

  def paypal_express_request
    @paypal_express_request ||=
      Paypal::Express::Request.new(Paypal::Express::Config.to_h)
  end

  def paypal_payment_request
    set_amount
    sessions_count_text = pluralize(sessions_count, "Fluentlee session")
    amount_text = number_to_currency(amount, locale: :en)
    description = I18n.t('payments.paypal.description',
                         sessions_count: sessions_count_text,
                         amount: amount_text)

    Paypal::Payment::Request.new(
      :action        => :Sale,
      :currency_code => self.currency.to_sym,
      :amount        => amount,
      :description   => description
    )
  end

  def self.cumulative_receipts(date)
    where('charged=true AND payments.created_at <= ?', date.end_of_day).sum('amount')
  end

end
