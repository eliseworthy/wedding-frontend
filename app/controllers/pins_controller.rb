class PinsController < ApplicationController

  def index
    pins = PinRequest.search(params[:search])
    @pins = pins.paginate(page: params[:page], per_page: 5)
    @weddings = WeddingRequest.find_all(user_id: current_user.id)
  end
end