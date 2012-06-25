class WeddingsController < ApplicationController

  def index
    @weddings = WeddingRequest.find_all
    unless @weddings.respond_to?(:each)
      redirect_to root_path, flash[:error] = @wedding
    end
  end

  def show
    @wedding = WeddingRequest.find(params[:id])
    unless @wedding.is_a?(Wedding)
      redirect_to root_path, flash[:error] = @wedding["error"]
    end
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
