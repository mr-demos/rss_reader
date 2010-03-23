class Feed < ActiveRecord::Base
  before_create :initialize_from_feed
  after_create :update_articles

  validate :url_is_valid

  has_many :articles, :order => 'published_at asc, created_at asc'

  def update_articles
    transaction do
      feed.entries.each do |entry|
        unless self.articles.exists?(:guid => entry.id)
          self.articles.create(
            :guid => entry.id,
            :title => entry.title,
            :url  => entry.url,
            :content => entry.content.blank? ? entry.summary : entry.content,
            :author => entry.author,
            :published_at => entry.published
          )
        end
      end
    end
  end

  protected

  def feed
    unless @feed
      @feed = Feedzirra::Feed.fetch_and_parse(url)
      @feed.sanitize_entries! if @feed
    end
    return @feed
  end

  def initialize_from_feed
    if feed
      self.title = feed.title
    else
      errors.add(:url, "does not point to an rss or atom feed")
      return false
    end
  end

  def url_is_valid
    errors.add(:url, "is invalid") unless url and url.match(URI.regexp)
  end
end
