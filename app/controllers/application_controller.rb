class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :recent_weddings

  def recent_weddings
    @recent_weddings = WeddingRequest.find_all.reverse.first(6)
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def set_key
    params[:api_key] = current_user.api_key if current_user
  end
  helper_method :set_key

  def require_login
    unless current_user
      flash[:error] = "Please login to access this page."
      redirect_to root_path
    end
  end
  helper_method :require_login
end
