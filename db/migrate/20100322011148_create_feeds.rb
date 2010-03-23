class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :url
      t.string :title, :default => "Untitled Feed"

      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
