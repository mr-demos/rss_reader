class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  has_many :articles, :through => :feed

  validates_presence_of :user_id
  validates_presence_of :url, :on => :create
  validates_associated :feed
  validates_uniqueness_of :feed_id, :scope => :user_id

  before_create :find_or_create_feed

  def url
    if new_record?
      @url
    else
      feed.url
    end
  end

  def url=(new_url)
    if new_record?
      @url = new_url
    else
      raise "Cannot change the url of a saved subscription"
    end
  end

  delegate :title, :to => :feed

  protected

  def find_or_create_feed
    return unless url
    self.feed = Feed.find_or_create_by_url(url)
    if feed.new_record?
      errors.add(:url, feed.errors.on(:url) || "is invalid")
      self.feed = nil
      return false
    end
  end
end
