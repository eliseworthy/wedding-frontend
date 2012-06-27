class HoneymoonRequest
  include HTTParty
  base_uri 'http://honeymoons.herokuapp.com'

  def self.search
    response = get('/honeymoon_items')
    response.map do |honeymoon|
      Honeymoon.new(honeymoon)
    end
  end
end