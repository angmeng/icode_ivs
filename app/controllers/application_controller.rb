# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :store_location

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :is_admin?
  helper_method :is_user?
  helper_method :current_user_department_id
  helper_method :current_user
  helper_method :company_name
  
  protected
  
  def check_authorization
    if is_user?
      unless can_access?(controller_name)
        flash[:error] = "Unauthorized access"
        redirect_to home_url
      end
    end
  end

  def can_access?(target)
    found = AccessibleMenu.find_by_name(target)
    current_user.department.accessible_menus.include?(found)
  end
    
  def set_locale
    I18n.locale = session[:locale]
  end
  
  def authenticated_admin
    unless is_admin?
      flash[:error] = "Unauthorized access"
      redirect_invalid_access
    end
  end
  
  def authenticated_admin_and_user
    unless is_admin? or is_user?
      flash[:error] = "Unauthorized access"
      redirect_invalid_access
    end
  end
  
  def warning_message
    @setting ||= Setting.first
    flash[:warning] = "Your Lisence is expired, please contact your administrator to prevent data lost." if @setting.blowfish <= Date.today 
  
  end

  def current_user_department_id
    current_user.department_id
  end
  
  
  def is_admin?
    current_user && current_user.department_id == Department::ADMIN
  end
  
  def is_super_admin?
    current_user && current_user.department_id == Department::ADMIN
  end

  def is_user?
    current_user && current_user.department_id > Department::ADMIN
  end
  
  
  def store_location
    session[:back] = request.referer
  end

  def company_name
     @company_name ||= Setting.first.company_name
  end

  def redirect_back_or_default(default)
    redirect_to(session[:back] || default)
    session[:back] = nil
  end

  def redirect_invalid_access
    if current_user
      redirect_to root_url
    else
      redirect_to admin_url
    end
  end
  
end
