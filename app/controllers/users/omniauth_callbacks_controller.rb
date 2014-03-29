class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in @user, :event => :authentication
      session[:friends_ids] = current_user.friends.map{|f| f['id']}
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?      
      redirect_to :root
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except("extra")      
      redirect_to :root
    end
  end
end