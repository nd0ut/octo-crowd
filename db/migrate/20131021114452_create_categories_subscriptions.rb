class CreateCategoriesSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :categories_subscriptions, :id => false do |t|
        t.references :category
        t.references :subscription
    end

    add_index :categories_subscriptions, [:category_id, :subscription_id], name: :index_categories_subscription
    add_index :categories_subscriptions, :category_id
    add_index :categories_subscriptions, :subscription_id
  end

  def self.down
    drop_table :categories_subscriptions
  end
end
