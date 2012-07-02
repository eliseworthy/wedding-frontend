class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash.now[:notice] = "Logged in as #{user.name}!"
      redirect_to user_weddings_path(current_user.id)
    else
      flash.now[:error] = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:notice] = "Logged out!"
    redirect_to root_url
  end
end
