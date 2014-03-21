class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many  :items
  has_many  :favorites
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :facebook_id => auth.uid).first
    
    if user && user.oauth_token.nil?
      user.update(oauth_token: auth.credentials.token, 
                  oauth_expires_at: Time.at(auth.credentials.expires_at))
    elsif !user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           facebook_id:auth.uid,
                           email:auth.info.email,
                           oauth_token: auth.credentials.token,
                           oauth_expires_at: Time.at(auth.credentials.expires_at),
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end  
  def self.find_or_create_by_uid(uid, params)
    user = User.where(provider: 'facebook', facebook_id: uid.to_s).first
    unless user
      user = User.create(  name: params[:name],
                           provider: 'facebook',
                           facebook_id: facebook_id.to_s,
                           email: "#{facebook_id.to_s}@fb.com",
                           password: Devise.friendly_token[0,20]
                        )
    end
    user
  end   

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end  

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
      nil # or consider a custom null object
  end

  def friends
    facebook.get_connections("me", "friends", fields: "id, name, picture")
  end

  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end

  def email_required?
    false
  end

end
