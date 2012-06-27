class WeddingsController < ApplicationController

  before_filter :authorize, only: [:edit, :update, :create, :show, :destroy]

  def index
    weddings = if params[:user_id]
      WeddingRequest.find_all(user_id: params[:user_id])
    else
      WeddingRequest.find_all
    end

    @weddings = weddings.paginate(page: params[:page], per_page: 5)

    unless @weddings.respond_to?(:each)
      redirect_to root_path, flash[:error] = @wedding
    end
  end

  def show
    @wedding = WeddingRequest.find(params[:id])
    @items =  ItemRequest.find_all_by_wedding(@wedding.id)
  end

  def new
    @wedding = WeddingRequest.create(params[:wedding])
  end

  def create
    params[:wedding][:user_id] = current_user.id
    @wedding = WeddingRequest.create(params[:wedding])
    if @wedding.success?
      redirect_to user_weddings_path(current_user.id), notice: "Successfully created wedding!"
    else
      render :new
    end
  end

  def edit
    @wedding = WeddingRequest.find(params[:id])
  end

  def update
    if params[:wedding][:user_id].to_i == current_user.id
      @wedding = WeddingRequest.update(params[:id], params[:wedding])
      if @wedding.success?
        redirect_to user_weddings_path(current_user.id), notice: "Successfully updated wedding!"
      else
        redirect_to user_weddings_path(current_user.id), notice: "Couldn't update this wedding"
      end
    else
      redirect_to user_weddings_path(current_user.id), notice: "You are not authorized to edit this wedding"
    end
  end

  def destroy
    @wedding = WeddingRequest.find(params[:id])
    if @wedding.user_id == current_user.id
      @wedding = WeddingRequest.destroy(params[:id])
      if @wedding.success?
        redirect_to user_weddings_path(current_user.id), notice: "Successfully deleted wedding"
      else
        redirect_to wedding_path(@wedding.id), notice: "Couldn't delete this wedding."
      end
    else
      redirect_to user_weddings_path(current_user.id), notice: "You are not authorized to edit this wedding"
    end
  end
end
