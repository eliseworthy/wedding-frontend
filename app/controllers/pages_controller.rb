class PagesController < ApplicationController
  def index
    if current_user
      redirect_to user_weddings_path(current_user.id)
    else
      @weddings = WeddingRequest.find_all.reverse
      @weddings = @weddings.first(3)
    end
  end
end