class WeddingsController < ApplicationController

  def index
    @weddings = HTTParty.get('http://wedding-api.herokuapp.com/weddings')
  end

end
