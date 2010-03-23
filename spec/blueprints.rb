require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.email { Faker::Internet.email }
Sham.feed_url { |n| "http://www.example-feed.com/#{n}/rss.xml" }

User.blueprint do
  email
end

Subscription.blueprint do
  user
  url { Sham.feed_url }
end


def feed_entries
  [Spec::Mocks::Mock.new('Feed Entry',
      :id => 'unique-id-1',
      :title => 'Entry 1',
      :url => 'http://www.sample-feed.com/entries/entry-1',
      :content => "<p>Content goes here</p>",
      :author => "Test User",
      :published => Time.now - 30.minutes
    ),
    Spec::Mocks::Mock.new('Feed Entry',
      :id => 'unique-id-2',
      :title => 'Entry 2',
      :url => 'http://www.sample-feed.com/entries/entry-2',
      :content => "<p>Content goes here</p>",
      :author => "Test User",
      :published => Time.now
    )
  ]
end

def old_feed
  Spec::Mocks::Mock.new(Feedzirra::Feed,
    :title => "Test Feed",
    :feed_url => 'http://www.sample-feed.com/rss',
    :entries => feed_entries[0,1]
  ).as_null_object
end

def new_feed
  Spec::Mocks::Mock.new(Feedzirra::Feed,
    :title => "Test Feed",
    :feed_url => 'http://www.sample-feed.com/rss',
    :entries => feed_entries
  ).as_null_object
end

def stub_feed(feed_mock=old_feed)
  Feedzirra::Feed.stub!(:fetch_and_parse).and_return(feed_mock)
end
