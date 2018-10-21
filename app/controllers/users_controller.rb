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
    if (params[:user[:confirm]] != params[:user[:new_word]])
      redirect_to edit_user_url(user), notice:"Passwords did not match", status: 500
    end
    user.email = params[:user[:email]]
    user.username = params[:user[:username]]
    if params[:user[:password]] != ''
      user.password = params[:user[:password]]
    end
    user.save
    redirect_to user
  end
  def destroy
    if(User.find(params[:id]).destroy)
      redirect_to users_path, notice: 'Successful Delete',status: 301
    else
      redirect_to users_path, notice: 'Delete Failed',status: 301
    end
  end
end
