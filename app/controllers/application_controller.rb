class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin_log?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin_log?
    logged_in? && current_user.admin?
  end

  def login_test
    unless logged_in?
      flash[:error] = "Please log in first."
      redirect_to root_path
    end
  end

  def admin_test
    unless admin_log?
      flash[:error] = "You can't do that."
      redirect_to root_path
    end
  end

  def validate_user
    unless @user == current_user || admin_log?
      flash[:error] = "You can't do that."
      redirect_to root_path
    end
    
  end

end
