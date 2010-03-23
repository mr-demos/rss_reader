require 'spec_helper'

describe Reading do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :article_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Reading.create!(@valid_attributes)
  end
end
