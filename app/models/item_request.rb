class ItemRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  def self.find_all_by_user_and_category(wedding_id, category_id)
    response = get('/items', query: { wedding_id: wedding_id, category_id: category_id })
    response["items"].map do |item|
      Item.new(item)
    end
  end
end