class DropPostsCategories < ActiveRecord::Migration
  def change
    drop_table :posts_categories
  end
end
