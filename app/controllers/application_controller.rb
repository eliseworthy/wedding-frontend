class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :recent_weddings, except: [:create, :update]

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  def recent_weddings
    @recent_weddings = WeddingRequest.find_all.reverse.first(3)
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
