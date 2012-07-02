class WeddingsController < ApplicationController

  before_filter :authorize, only: [:edit, :update, :create, :destroy]
  before_filter :set_key, only: [:edit, :update, :create, :destroy]

  def index
    weddings = if params[:user_id]
      WeddingRequest.find_all(user_id: params[:user_id])
    else
      WeddingRequest.find_all.reverse
    end

    @weddings = weddings.paginate(page: params[:page], per_page: 5)

    unless @weddings.respond_to?(:each)
      flash[:error] = @weddings
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
    @wedding = WeddingRequest.create(params[:wedding])
  end

  def create
    if current_user
      params[:wedding][:user_id] = current_user.id
      response = WeddingRequest.create(params[:wedding])
      if response.success?
        flash[:notice] = "Successfully created wedding!"
        redirect_to user_weddings_path(current_user.id)
      else
        flash[:error] = "Unable to create wedding. See errors below."
        render :new
      end
    else
      flash[:error] = "Please login to create weddings."
      redirect_to root_path
    end
  end

  def edit
    @wedding = WeddingRequest.find(params[:id])
  end

  def update
    if current_user
      if params[:wedding][:user_id].to_i == current_user.id
        response = WeddingRequest.update(params[:id], params[:wedding])
        if response.success?
          flash[:notice] = "Successfully updated wedding!"
          redirect_to wedding_path(response.parsed_response[:id])
        else
          flash[:notice] = "Couldn't update this wedding"
          redirect_to wedding_path(response.parsed_response[:id])
        end
      else
        flash[:notice] = "You are not authorized to edit this wedding."
        redirect_to user_weddings_path(current_user.id)
      end
    else
      flash[:error] = "Please login to edit weddings."
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      @wedding = WeddingRequest.find(params[:id])
      if @wedding.user_id == current_user.id
        response = WeddingRequest.destroy(params[:id])
        if response.success?
          flash[:notice] = "Successfully deleted wedding."
          redirect_to user_weddings_path(current_user.id)
        else
          flash[:notice] = "Couldn't delete this wedding."
          redirect_to user_weddings_path(current_user.id)
        end
      else
        flash[:notice] = "You are not authorized to edit this wedding"
        redirect_to weddings_path
      end
    else
      flash[:error] = "Please login to delete weddings."
      redirect_to root_path
    end
  end
end
