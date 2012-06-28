class PagesController < ApplicationController
  def index
    @weddings = WeddingRequest.find_all.reverse
    @weddings = @weddings.first(3)
  end
end