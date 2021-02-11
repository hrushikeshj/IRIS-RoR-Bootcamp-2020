class AddNColumsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :title, :text
    add_column :articles, :topic, :text
    add_column :articles, :tags, :text
  end
end
