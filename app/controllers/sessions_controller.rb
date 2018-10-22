class SessionsController < ApplicationController
  def new
    render :new
  end
  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password] + $salt)
      login(user)
      redirect_to user
    else
      flash.now[:error] = "Invalid Username or Password"
      render :new
    end
  end
  def destroy
  end
end
