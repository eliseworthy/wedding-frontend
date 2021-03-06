class WeddingsController < ApplicationController

  before_filter :require_login, only: [:update, :create, :destroy]
  before_filter :set_key, only: [:edit, :update, :create, :destroy]

  def index
    weddings = if params[:user_id]
      WeddingRequest.find_all(user_id: params[:user_id])
    else
      WeddingRequest.find_all.reverse
    end

    @weddings = weddings.paginate(page: params[:page], per_page: 5)

    unless @weddings.respond_to?(:each)
      flash.now[:error] = @weddings
      redirect_to root_path
    end
  end

  def show
    if current_user
      @weddings = WeddingRequest.find_all(user_id: current_user.id)
    end
    @wedding = WeddingRequest.find(params[:id])
    @items =  ItemRequest.find_all_by_wedding(@wedding.id)
  end

  def new
  end

  def create
    params[:wedding][:user_id] = current_user.id
    response = WeddingRequest.create(params[:wedding], params[:api_key])
    if response.success?
      flash.now[:notice] = "Successfully created wedding!"
      redirect_to user_weddings_path(current_user.id)
    else
      flash.now[:error] = "Unable to create wedding. See errors below."
      render :new
    end
  end

  def edit
    @wedding = WeddingRequest.find(params[:id])
  end

  def update
    if params[:wedding][:user_id].to_i == current_user.id
      response = WeddingRequest.update(params[:id], params[:wedding], params[:api_key])
      if response.success?
        flash.now[:notice] = "Successfully updated wedding!"
        redirect_to wedding_path(response.parsed_response[:id])
      else
        flash.now[:notice] = "Couldn't update this wedding"
        redirect_to wedding_path(params[:wedding][:id])
      end
    else
      flash.now[:notice] = "You are not authorized to edit this wedding."
      redirect_to user_weddings_path(current_user.id)
    end
  end

  def destroy
    @wedding = WeddingRequest.find(params[:id])
    if @wedding.user_id == current_user.id
      response = WeddingRequest.destroy(params[:id], params[:api_key])
      if response.success?
        flash.now[:notice] = "Successfully deleted wedding."
        redirect_to user_weddings_path(current_user.id)
      else
        flash.now[:notice] = "Couldn't delete this wedding."
        redirect_to user_weddings_path(current_user.id)
      end
    else
      flash.now[:notice] = "You are not authorized to edit this wedding"
      redirect_to weddings_path
    end
  end
end
