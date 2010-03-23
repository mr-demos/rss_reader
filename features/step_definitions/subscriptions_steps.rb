Given /^the following subscriptions:$/ do |subscriptions|
  Subscriptions.create!(subscriptions.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) subscriptions$/ do |pos|
  visit subscriptions_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following subscriptions:$/ do |expected_subscriptions_table|
  expected_subscriptions_table.diff!(tableish('table tr', 'td,th'))
end

Given /^feed URLs are stubbed$/ do
  stub_feed
end

