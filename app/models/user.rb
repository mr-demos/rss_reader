class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :readings

  validates_format_of :email, :with => /^[a-zA-Z0-9_.\-+]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$/
  validates_uniqueness_of :email
end
