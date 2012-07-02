class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :name, :api_key

  validates_presence_of :email, :name, :password_confirmation
  validates_uniqueness_of :email, :name

  after_create :generate_api_key

    def generate_api_key
      key = Digest::MD5.hexdigest(
        rand(424242424242424242).to_s
      )
      self.update_attributes api_key: key
    end
end
