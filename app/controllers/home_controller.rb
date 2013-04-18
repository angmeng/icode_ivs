class HomeController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale
  
  def index
    
  end

  def change_language
    session[:locale] == :cn ? session[:locale] = :en : session[:locale] = :cn
    redirect_to :action => "index"
  end


end
