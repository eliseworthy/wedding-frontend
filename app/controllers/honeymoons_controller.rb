class HoneymoonsController < ApplicationController

  def index
    honeymoons = HoneymoonRequest.search
    @honeymoons = honeymoons.paginate(page: params[:page], per_page: 5)
    if current_user
      @weddings = WeddingRequest.find_all(user_id: current_user.id)
    end
  end
end
