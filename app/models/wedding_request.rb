class WeddingRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  attr_accessor :flash_notice

  def self.find_all
    response = get('/weddings')
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