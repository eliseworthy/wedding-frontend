class ItemRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  def self.find_all_by_wedding(wedding_id)
    response = get('/items', query: { wedding_id: wedding_id })
    response["items"].map do |item|
      Item.new(item)
    end
  end

   def self.create(attributes)
    post("/items/", query: {item: attributes})
  end
end