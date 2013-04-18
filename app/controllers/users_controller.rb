class UsersController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale
  
  def index
    if is_admin?
      @users = User.paginate(:page => params[:page], :per_page => 20, :order => "username")
    else
      @users = User.all(:conditions => ["id = ? ", session[:user_id]]).paginate(:page => params[:page], :per_page => 20, :order => "username")
    end
  end
  
  def edit
    if is_admin?
      @user = User.find(params[:id])
    else
     
        @user = User.find(session[:user_id])
 
    end

  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = (t "flashes.successfully_updated")
      redirect_to @user
    else
      flash[:error] = (t "flashes.saving_failed")
      render :action => "edit"
      
    end
  end
  
  def change_password
    if is_admin?
      @user = User.find(params[:id])
    else
    
        @user = User.find(session[:user_id])

    end
  end
  
  def update_password
    @user = User.find(params[:id])
    
    passed, msg = @user.check_password(params[:user])
    
    if passed
      flash[:notice] = msg
      redirect_to @user
    else
      flash[:error] = msg
      render :action => "change_password"
      
    end
  end
  
  def new
    if is_admin?
      @user = User.new
    else
     
        flash[:error] = "Unauthorized access"
        redirect_to(home_url)
 
    end
  end
  
  def show
    if is_admin?
      @user = User.find(params[:id])
    else
        @user = User.find(session[:user_id])
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = (t "flashes.successfully_created")
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def destroy
    if is_admin?
      @user = User.find(params[:id])

      passed, msg = @user.verify_destroy
      if passed
        flash[:notice] = msg
      else
        flash[:error] = msg
      end
    else
      flash[:error] = "you dont have the access right"
    end
    redirect_back_or_default(users_url)
  end
  
end
