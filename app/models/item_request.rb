class ItemRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  def self.find_all_by_wedding(wedding_id)
    response = get('/items', query: { wedding_id: wedding_id })
    response["items"].map do |item|
      Item.new(item)
    end
  end

  def self.find(id)
  	response = get("/items/#{id}")
  	if response.success?
      Item.new(response)
    else
      response
    end
  end

  def self.create(item_attributes, api_key)
    post("/items/", query: {item: item_attributes, api_key: api_key})
  end

  def self.update(id, item_attributes, api_key)
  	put("/items/#{id}", body: {item: item_attributes, api_key: api_key})
  end

  def self.destroy(id, api_key)
    delete("/items/#{id}", body: {api_key: api_key})
  end

end