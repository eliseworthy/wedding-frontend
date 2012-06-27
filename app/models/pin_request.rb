class PinRequest
  include HTTParty
  base_uri 'http://pin-search.herokuapp.com'

  def self.search(search_items=nil)
  	if search_items
      response = get('/pin_items', query: { search: search_items })
    else
      response = get('/pin_items')
    end
    response.map do |pin|
      Pin.new(pin)
    end
  end
end