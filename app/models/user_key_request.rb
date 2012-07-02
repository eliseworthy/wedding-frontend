class UserKeyRequest
  include HTTParty
  base_uri 'http://wedding-api.herokuapp.com'

  def self.save_key(api_key)
    post('/user_keys', query: {api_key: api_key})
  end
end