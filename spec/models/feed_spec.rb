require 'spec_helper'

describe Feed do

  before do
    @feed = Feed.new
    @url = "http://www.sample-feed.com/rss.xml"
  end

  context "validation" do
    it "should not be valid without a url" do
      @feed.should_not be_valid
      @feed.should have_errors_on(:url)
    end

    it "should not be valid with an invalid url" do
      @feed.url = "this is not a real url"
      @feed.should_not be_valid
      @feed.should have_errors_on(:url)
    end
  end

  context "creation" do
    before do
      @feed.url = @url
      stub_feed(old_feed)
      @feed.save
    end

    it "should set its title from the rss/atom feed" do
      @feed.title.should == old_feed.title
    end

    it "should create articles from the rss/atom feed" do
      @feed.articles.should_not be_empty
      first_article = @feed.articles.first
      first_article.title.should == feed_entries[0].title
      first_article.content.should == feed_entries[0].content
      first_article.url.should == feed_entries[0].url
      first_article.author.should == feed_entries[0].author
      first_article.guid.should == feed_entries[0].id
      #first_article.published_at.should == feed_entries[0].published
    end
  end

  describe "#update_articles" do
    before do
      @feed.url = @url
      stub_feed(old_feed)
      @feed.save
      @articles_before = @feed.articles.dup
      # Feed#feed is cached, so we need a new instance
      @feed = Feed.find(@feed.id)
      stub_feed(new_feed)
      @feed.update_articles
    end

    it "should not recreate existing articles" do
      @articles_before.each do |article|
        @feed.articles.count(:conditions => {:guid => article.guid}).should == 1
      end
    end

    it "should create articles for new items" do
      # I hate being dependent on a fixture, since then the test data is outside
      # of the test, but in this case it's either that or a heredoc
      @feed.articles.length.should == @articles_before.length + 1
      newest_article = @feed.articles.last
      newest_article.title.should == feed_entries[1].title
      newest_article.content.should == feed_entries[1].content
      newest_article.url.should == feed_entries[1].url
      newest_article.author.should == feed_entries[1].author
      newest_article.guid.should == feed_entries[1].id
      #newest_article.published_at.should == feed_entries[1].published
    end
  end
end
