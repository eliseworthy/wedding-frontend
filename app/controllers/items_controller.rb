class ItemsController < ApplicationController

  before_filter :require_login, only: [:create, :update, :destroy]
  before_filter :set_key, only: [:update, :create, :destroy]
  before_filter :find_wedding, only: [:create, :update]
  before_filter :find_wedding_from_item, only: [:destroy]
  before_filter :check_current_user, only: [:create, :update, :destroy]
  before_filter :set_item_parameters, only: :create

  def create
    response = ItemRequest.create(params[:item], params[:api_key])

    if response.success?
      flash[:notice] = "Successfully saved idea!"
      redirect_to :back
    else
      flash.now[:error] = "Unable to save this idea."
      redirect_to :back
    end
  end

  def edit
    @item = ItemRequest.find(params[:id])
  end

  def update
    response = ItemRequest.update(params[:id], params[:item], params[:api_key])

    if response.success?
      flash[:notice] = "Successfully updated idea!"
      redirect_to :back
    else
      flash[:error] = "Couldn't update this idea."
      redirect_to :back
    end
  end

  def destroy
    response = ItemRequest.destroy(params[:id], params[:api_key])

    if response.success?
      flash[:notice] = "Successfully deleted idea."
      redirect_to :back
    else
      flash[:error] = "Couldn't delete this wedding item."
      redirect_to :back
    end
  end

  private

  def find_wedding
    @wedding = WeddingRequest.find(params[:item][:wedding_id])
  end

  def find_wedding_from_item
    @item = ItemRequest.find(params[:id])
    @wedding = WeddingRequest.find(@item.wedding_id)
  end


  def check_current_user
    if @wedding.user_id != current_user.id
      flash.now[:error] = "You are not authorized to modify this wedding."
      redirect_to :back
    end
  end

  def set_item_parameters
    params[:item][:wedding_id] = @wedding.id

    if params[:item][:description].blank?
      params[:item][:description] = "from Pinterest search"
    end
  end
end