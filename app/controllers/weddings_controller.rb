class WeddingsController < ApplicationController

  before_filter :authorize, only: [:edit, :update, :create, :show, :destroy]

  def index
    @weddings = WeddingRequest.find_all
    unless @weddings.respond_to?(:each)
      redirect_to root_path, flash[:error] = @wedding
    end
  end

  def show
    @wedding = WeddingRequest.find(params[:id])
    @items =  ItemRequest.find_all_by_user_and_category(@wedding.id, 1)
  end

  def create
    @wedding = WeddingRequest.create(params[:wedding])
  end

  def update
    WeddingRequest.update(params[:id], params[:wedding])
  end

  def destroy
    @wedding = WeddingRequest.destroy(params[:id])
  end

end
