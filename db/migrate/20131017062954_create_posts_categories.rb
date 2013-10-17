class CreatePostsCategories < ActiveRecord::Migration
  def self.up
    create_table :posts_categories, :id => false do |t|
        t.references :post
        t.references :category
    end

    add_index :posts_categories, [:post_id, :category_id]
    add_index :posts_categories, :post_id
    add_index :posts_categories, :category_id
  end

  def self.down
    drop_table :posts_categories
  end
end