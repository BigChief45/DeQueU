class AddCachedVotesUpToStories < ActiveRecord::Migration
  def change
    remove_column :stories, :cached_votes_total
    remove_column :stories, :comments_count
    add_column :stories, :cached_votes_up, :integer, :default => 0
  end
end
