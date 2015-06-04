class AddCachesToStories < ActiveRecord::Migration
  def change
    
    add_column :stories, :cached_votes_total, :integer, :default => 0
    
  end
end
