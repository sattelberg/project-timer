class UsersController < ApplicationController
  def show
    if !current_user
      flash[:error] = "You must log in to see that page"
      redirect_to login_url  and return
    end
    @user = User.find(params[:id])
    render :show
  end
  def index
    if !current_user
      flash[:error] = "You must log in to see that page"
      redirect_to login_url  and return
    end
    @users = User.all
    render :index
  end
  def edit
    if !current_user
      flash[:error] = "You must log in to see that page"
      redirect_to login_url and return
    end
    @user = User.find(params[:id])
    render :edit
  end
  def update
    @user = User.find(params[:id])
    uparam = params[:user]
    if (uparam[:confirm] != uparam[:password])
      flash.now[:error] = "Passwords did not match"
      render :edit
    else
      @user.email = uparam[:email]
      @user.username = uparam[:username]
      if uparam[:password] != ''
        @user.password = uparam[:password]+$salt
      end
      @user.updated_at = DateTime.current.in_time_zone('UTC')
      if @user.save
        flash[:notice] = "Succesfully Updated"
        redirect_to @user, status: 301
      else
        flash.now[:error] = "Error: Not Updated"
        render :edit
      end
    end
  end
  def new
    @user = User.new
    render :new
  end
  def create
    @user = User.new
    uparam = params[:user]
    if (uparam[:confirm] != uparam[:password])
      flash.now[:error] = "Passwords did not match"
      render :new
    else
      @user.email = uparam[:email]
      @user.username = uparam[:username]
      @user.password = uparam[:password]+$salt
      @user.updated_at = DateTime.current.in_time_zone('UTC')
      @user.created_at = @user.updated_at
      if @user.save
        flash[:notice] = "User Registered"
        redirect_to login_path, status: 301
      else
        flash[:error]=@user.errors.full_messages.join(" ").html_safe
        render :new
      end
    end
  end
  def destroy
    if(User.find(params[:id]).destroy)
      flash[:notice] = "Successful Delete"
      redirect_to users_path, status: 301
    else
      flash[:error] = "Error: Failed to Delete"
      redirect_to users_path, status: 301
    end
  end
end
