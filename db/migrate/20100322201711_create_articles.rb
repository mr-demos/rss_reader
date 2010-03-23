class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.integer :feed_id
      t.string :guid
      t.string :title
      t.text :url
      t.text :content
      t.string :author
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
