class PaymentsController < ApplicationController
  def index
    @payments = current_user.payments.charged
  end

  def new
    currency = currency_for_country(current_user.role.country)
    @payment = Payment.new_default(currency: currency)
  end

  def create
    if promo_code = payment_with_promo_code_params[:promo_code]
      redeem_promo_code(promo_code)
    else
      @payment = Payment.new(new_payment_params)
      @payment.currency = currency_for_country(current_user.role.country)
      @payment.user = current_user
      @payment.save!
      redirect_to @payment
    end
  end

  def show
    @payment = current_user.payments.find(params[:id])

    redirect_to billing_account_url if @payment.charged?
  end

  def update
    @payment = current_user.payments.find(params[:id])

    payment_method = params[:payment] && params[:payment][:payment_method]

    if !@payment.charged? && payment_method.present?
      @payment.update_attribute(:payment_method, payment_method)
    end

    if not @payment.charged?
      if @payment.paypal?
        process_paypal_payment
      elsif @payment.stripe?
        process_stripe_payment
      elsif @payment.alipay?
        process_alipay_payment
      end
    else
      redirect_to billing_account_url
    end
  end

  def paypal_success
    @payment = current_user.payments.find(params[:id])
    @payment.paypal_token    = params[:token]
    @payment.paypal_payer_id = params[:PayerID]
    @payment.save!

    redirect_to @payment
  end

  def paypal_cancel
    redirect_to new_payment_url, alert: I18n.t('payments.paypal.payment-cancel')
  end

  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)

    if Alipay::Notify.verify?(notify_params) && params[:trade_status] == 'TRADE_FINISHED'
      @payment = Payment.find(params[:out_trade_no])
      @payment.charge
    end

    render text: "success", status: :ok
  end

  def alipay_return
    @payment = current_user.payments.find(params[:id])
    redirect_to @payment
  end

  private
  def new_payment_params
    params.require(:payment).permit(:sessions_count)
  end

  def successful_payment_flash
    {
      notice: I18n.t("payments.#{@payment.payment_method}.payment-succeeded.title"),
      flash: {
        body: I18n.t("payments.#{@payment.payment_method}.payment-succeeded.body",
                     amount: number_to_currency(@payment.amount, unit: symbol_for_currency(@payment.currency)),
                     sessions_count: current_user.reload.sessions_count)
      }
    }
  end

  def successful_promo_code_flash
    {
      notice: I18n.t('alert.payments.promo_code_successful.title'),
      flash: {
        body: I18n.t('alert.payments.promo_code_successful.body',
                     sessions_count: @promotion.free_session_count)
      }
    }
  end

  def payment_with_promo_code_params
    params.require(:payment).permit(:promo_code)
  end

  def process_paypal_payment
    if !@payment.charged? && @payment.paypal_payer_id.blank?
      @payment.request_paypal_url(
        paypal_success_payment_url(@payment),
        paypal_cancel_payment_url(@payment)
      )

      redirect_to @payment.paypal_url
    elsif @payment.valid_paypal_payment?
      @payment.charge
      redirect_to billing_account_url, successful_payment_flash
    else
      redirect_to @payment
    end
  end

  def process_stripe_payment
    @payment.update_column(:stripe_token, params[:stripeToken])

    if !@payment.charged? && @payment.stripe_token.present? && @payment.charge
      redirect_to billing_account_url, successful_payment_flash
    else
      redirect_to @payment, alert: I18n.t('payments.stripe.payment-error')
    end
  end

  def redeem_promo_code(code)
    if @promotion = current_user.redeem_promotion(code)
      redirect_to billing_account_url, successful_promo_code_flash
    else
      @payment = Payment.new_default
      @payment.currency = currency_for_country(current_user.role.country)
      flash.now[:alert] = I18n.t('alert.payments.promo_code_failed.title')
      render :new
    end
  end

  def process_alipay_payment
    if !@payment.charged?
      @payment.request_alipay_url(alipay_notify_payment_url(@payment),
                                  alipay_return_payment_url(@payment))
      redirect_to @payment.alipay_url
    else
      redirect_to @payment
    end
  end

end
