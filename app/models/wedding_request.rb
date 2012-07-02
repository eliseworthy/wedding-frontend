class WeddingRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  attr_accessor :flash_notice

  def self.find_all(args={})
    response = get('/weddings', query: {query: args})
    if response.code == 200
      response["weddings"].map do |wedding|
        Wedding.new(wedding)
      end
    else
      flash_notice = "Unable to retrieve weddings."
    end
  end

  def self.find(id)
    response = get("/weddings/#{id}")
    if response.success?
      Wedding.new(response)
    else
      response
    end
  end

  def self.update(id, attributes, api_key)
    put("/weddings/#{id}", query: {wedding: attributes, api_key: api_key})
  end

  def self.create(wedding_attributes, api_key)
    post("/weddings/", query: {wedding: wedding_attributes, api_key: api_key})
  end

  def self.destroy(id, api_key)
    response = delete("/weddings/#{id}", query: {api_key: api_key})
  end
end