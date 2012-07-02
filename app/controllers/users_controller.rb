class UsersController < ApplicationController
  def new
    flash[:error] = params[:error]
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      UserMailer.signup_confirmation(@user.name, @user.email).deliver
      UserKeyRequest.save_key(@user.api_key)
      flash[:notice] = "Thanks, #{current_user.name}! Your account was successfully created!"
      redirect_to user_weddings_path(current_user.id)
    else
      render :new
    end
  end
end
