class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :name

  validates_uniqueness_of :email, :name
end
