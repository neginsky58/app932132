class AdminController < ApplicationController
  

  def new
    @admin = Admin.new    
    
    respond_to do |format|
      if current_admin_user
        format.html { redirect_to users_admins_url }
        format.json { render json: 'success' }
      else
        format.html { render layout: "admin_login" }
        format.json { render json: @admin }
      end
    end    
  end

  def create    
    
    admin_user = Admin.find_by_username(params[:admin]['username'])
    
    respond_to do |format|
      if !admin_user.nil? && admin_user.password == params[:admin]['password']
        flash[:success] = 'Successfully logged in as asmin user'
        session[:admin_user] = admin_user
        format.html { redirect_to users_admins_url }
        format.json { render json: 'success', status: :success }
      else
        flash[:danger] = 'Invalid user name or wrong password!'
        @admin = Admin.new({:username => params[:admin]['username'], :password=>params[:admin]['password']})
        format.html { render action: "new", layout: 'admin_login'}
        format.json { render json: 'Invalid user name or wrong password', status: :unprocessable_entity }
      end
    end    
  end

  def users

    @users = User.all
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.json { render json: @users }
    end
  end

  def circles
  end

  def settings
  end

  def index
  end

  def current_admin_user
    return session[:admin_user]    
  end

end
