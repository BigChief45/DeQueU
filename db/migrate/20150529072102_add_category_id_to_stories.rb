class AddCategoryIdToStories < ActiveRecord::Migration
  def change
    remove_column :stories, :name
    add_column :stories, :category_id, :integer
  end
end
