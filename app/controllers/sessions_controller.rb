class SessionsController < ApplicationController
 
  
  def new
  end

  def outlet
    
  end
  
  def create
    #setting = Setting.first
    #if setting.blowfish >= Date.today 
  
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      check_language(user)
      set_locale
      flash[:notice] = (t "flashes.successfully_logged_in")
      redirect_to_target_or_default(home_url)
    else
      flash.now[:error] = (t "flashes.invalid_login")
      render :action => 'new'
    end
    #else
    #   flash[:error] = "Your license is expired. Please contact your administrator"
    #   redirect_to login_url
    #end
  end
  
  def destroy
    admin = is_admin? ?  true : false
    reset_session
    flash[:notice] = (t "flashes.successfully_logout")
    if admin
      redirect_to admin_url
    else
      redirect_to root_url
    end
   
  end
  
  private
  
  def check_language(user)
    if user.language == Setting::ENGLISH
      session[:locale] = :en
    elsif user.language == Setting::CHINESE
      session[:locale] = :cn
    end
  end
  
end
