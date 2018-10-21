class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :show
  end
  def index
    @users = User.all
    render :index
  end
  def edit
    @user = User.find(params[:id])
    render :edit
  end
  def update
    user = User.find(params[:id])
    uparam = params[:user]
    if (uparam[:confirm] != uparam[:new_word])
      flash[:error] = "Passwords did not match"
      redirect_to edit_user_url(user), status: 301
    else
      user.email = uparam[:email]
      user.username = uparam[:username]
      if uparam[:password] != ''
        user.password = uparam[:password]
      end
      user.updated_at = DateTime.current.in_time_zone('UTC')
      if user.save
        flash[:notice] = "Succesfully Updated"
        redirect_to user, status: 301
      else
        flash[:error] = "Error: Not Updated"
        redirect_to edit_user_path(params[:id]), status: 301
      end
    end
  end
  def new
    @user = User.new
    render :new
  end
  def create
    user = User.new
    uparam = params[:user]
    if (uparam[:confirm] != uparam[:new_word])
      redirect_to new_user_url, notice:"Passwords did not match", status: 500
    else
      user.email = uparam[:email]
      user.username = uparam[:username]
      if uparam[:password] != ''
        user.password = uparam[:password]
      end
      user.updated_at = DateTime.current.in_time_zone('UTC')
      user.created_at = user.updated_at
      if user.save
        flash[:notice] = "Sucessfully Created"
        redirect_to user, status: 301
      else
        flash[:error] = "Error During Creation"
        redirect_to create_user_url, status: 301
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
