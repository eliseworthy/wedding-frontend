class PinsController < ApplicationController
  def index
    @pins = PinRequest.search(params[:search])
    if current_user
      @weddings = WeddingRequest.find_all(user_id: current_user.id)
    end
  end
end
