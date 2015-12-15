class AccessibleMenusController < ApplicationController
  before_filter :authenticated_admin
  before_filter :set_locale
  
  def index
    @menus = AccessibleMenu.all
  end
  
  def show
    @menu = AccessibleMenu.find(params[:id])
  end
  
  def new
    @menu = AccessibleMenu.new
  end
  
  def create
    @menu = AccessibleMenu.new(params[:accessible_menu])
    if @menu.save
      flash[:notice] = "Successfully created menu."
      redirect_to @menu
    else
      render :action => 'new'
    end
  end
  
  def edit
    @menu = AccessibleMenu.find(params[:id])
  end
  
  def update
    @menu = AccessibleMenu.find(params[:id])
    if @menu.update_attributes(params[:accessible_menu])
      flash[:notice] = "Successfully updated menu."
      redirect_to @menu
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @menu = AccessibleMenu.find(params[:id])
    @menu.destroy
    flash[:notice] = "Successfully destroyed menu."
    redirect_to banks_url
  end
end
