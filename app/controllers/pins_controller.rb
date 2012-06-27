class PinsController < ApplicationController

  def index
    pins = PinRequest.search(params[:search])
    @pins = pins.paginate(page: params[:page], per_page: 5)
  end
end
