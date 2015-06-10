class AddCommentsCountToStories < ActiveRecord::Migration
  def change
    add_column :stories, :comments_count, :integer, :null => false, :default => 0
  end
end
