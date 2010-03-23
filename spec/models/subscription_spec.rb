require 'spec_helper'

describe Subscription do
  before(:each) do
    @user = User.make
    @subscription = Subscription.new
    @feed_url = "http://www.mysite.com/rss.xml"
  end

  context "validation" do
    it "should be valid with a url and user" do
      @subscription.user = @user
      @subscription.url = @feed_url
      @subscription.should be_valid
    end

    it "should not be valid without a user" do
      @subscription.url = @feed_url
      @subscription.should_not be_valid
      @subscription.should have_errors_on(:user_id)
    end

    it "should not be valid without a url" do
      @subscription.user = @user
      @subscription.should_not be_valid
      @subscription.should have_errors_on(:url)
    end
  end

  context "creation" do
    before do
      @subscription.user = @user
      @subscription.url = @feed_url
      stub_feed
    end

    it "should find_or_create a feed for the url" do
      @subscription.feed.should be_nil
      @subscription.save
      @subscription.feed.should_not be_nil
    end

    it "should not save if the url is invalid" do
      @subscription.url = "invalid url"
      @subscription.save.should be_false
      @subscription.feed.should be_nil
    end
  end

  describe "#title" do
    it "should delegate to feed" do
      feed = mock_model(Feed)
      title = "Banana Phone"
      @subscription.should_receive(:feed).and_return(feed)
      feed.should_receive(:title).and_return(title)
      @subscription.title.should == title
    end
  end
end
