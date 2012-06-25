class WeddingRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  def self.find_all
    response = get('/weddings')
    response["weddings"].map do |wedding|
      Wedding.new(wedding)
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

  def self.update(id, attributes)
    response = put("/weddings/#{id}", query: attributes)
    response.success?
  end

  def self.create(attributes)
    response = post("/weddings/", query: attributes)
    response.success?
  end

  def self.destroy(id)
    response = delete("/weddings/#{id}")
    response.success?
  end
end