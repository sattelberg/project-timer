module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    flash[:notice] = "Logged In"
    current_user
  end
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  def check_login
    unless !current_user.nil?
      flash[:error] = "You must log in to see that page"
      redirect_to login_url
    end
  end
end
