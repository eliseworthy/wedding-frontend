class WeddingsController < ApplicationController

  def index
    @weddings = WeddingRequest.find_all
  end

  def show
    @wedding = WeddingRequest.find(params[:id])
    unless @wedding.is_a?(Wedding)
      redirect_to root_path, flash[:error] = @wedding["error"]
    end
  end
end
