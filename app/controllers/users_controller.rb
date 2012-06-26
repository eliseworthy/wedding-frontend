class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      UserMailer.signup_confirmation(@user.email).deliver
      redirect_to root_url, notice: "Time to terrorize!"
    else
      render "new"
    end
  end
end
