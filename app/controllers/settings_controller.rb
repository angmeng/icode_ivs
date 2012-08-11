class SettingsController < ApplicationController
  before_filter :authenticated_admin
  before_filter :set_locale
  
  
  def index
    @settings = Setting.all
  end
  
  def show
    @setting = Setting.find(params[:id])
  end
  
  def new
    @setting = Setting.new
  end
  
  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      flash[:notice] = "Successfully created setting."
      redirect_to @setting
    else
      render :action => 'new'
    end
  end
  
  def edit
    @setting = Setting.find(params[:id])
  end
  
  def update
    @setting = Setting.find(params[:id])
    if @setting.update_attributes(params[:setting])
      flash[:notice] = "Successfully updated setting."
      redirect_to @setting
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy
    flash[:notice] = "Successfully destroyed setting."
    redirect_to settings_url
  end
end
