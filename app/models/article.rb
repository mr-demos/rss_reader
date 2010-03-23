class Article < ActiveRecord::Base
  belongs_to :feed
  has_many :readings

  def read_by?(user)
    readings.exists?(:user_id => user.id)
  end
end
