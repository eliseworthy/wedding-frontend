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

  def self.create(attributes)
    post("/items/", query: {item: attributes})
  end

  def self.update(item_id, attributes)
  	put("/items/#{item_id}", body: {item: attributes})
  end
end