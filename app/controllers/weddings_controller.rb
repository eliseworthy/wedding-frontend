class WeddingsController < ApplicationController

  def index
    weddings_response = HTTParty.get('http://wedding-api.herokuapp.com/weddings')
    @weddings = weddings_response["weddings"]
  end
end
