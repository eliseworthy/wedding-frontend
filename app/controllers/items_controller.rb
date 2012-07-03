class ItemsController < ApplicationController

  before_filter :require_login, only: [:create, :update, :destroy]
  before_filter :set_key, only: [:update, :create, :destroy]

  def create
    @wedding = WeddingRequest.find(params[:item][:wedding_id])
    if @wedding.user_id == current_user.id

      params[:item][:wedding_id] = @wedding.id
      if params[:item][:description].blank?
        params[:item][:description] = "Search Results"
      end

      response = ItemRequest.create(params[:item], params[:api_key])
      if response.success?
        flash[:notice] = "Successfully saved idea!"
        redirect_to :back
      else
        @items = ItemRequest.find_all_by_wedding(@wedding.id)
        flash.now[:error] = "Unable to save this idea."
        redirect_to :back
      end

    else
      flash.now[:error] = "You are not authorized to save ideas to this wedding."
      redirect_to :back
    end
  end

  def edit
    @item = ItemRequest.find(params[:id])
  end

  def update
    @wedding = WeddingRequest.find(params[:item][:wedding_id])
    if @wedding.user_id == current_user.id
      @item = ItemRequest.update(params[:id], params[:item], params[:api_key])
      @wedding_id = params[:item][:wedding_id]

      if @item.success?
        flash.now[:notice] = "Successfully updated idea!"
        redirect_to wedding_path(@wedding_id)
      else
        flash.now[:error] = "Couldn't update this idea."
        redirect_to wedding_path(@wedding_id)
      end

    else
      @items = ItemRequest.find_all_by_wedding(@wedding.id)
      flash.now[:error] = "You are not authorized to save ideas to this wedding."
      redirect_to weddings_path(current_user.id)
    end
  end

  def destroy
    @item = ItemRequest.find(params[:id])
    @wedding = WeddingRequest.find(@item.wedding_id)
    if @wedding.user_id == current_user.id
      @item = ItemRequest.destroy(params[:id], params[:api_key])
      if @item.success?
        flash.now[:notice] = "Successfully deleted idea."
        redirect_to wedding_path(@wedding.id)
      else
        flash.now[:error] = "Couldn't delete this wedding item."
        redirect_to wedding_path(@wedding.id)
      end
    else
      @items = ItemRequest.find_all_by_wedding(@wedding.id)
      flash.now[:error] = "You are not authorized to delete ideas for this wedding."
      redirect_to weddings_path(current_user.id)
    end
  end
end