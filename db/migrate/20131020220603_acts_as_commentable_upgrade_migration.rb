class ActsAsCommentableUpgradeMigration < ActiveRecord::Migration
  def change
    rename_column :comments, :comment, :body
    add_column :comments, :subject, :string
    add_column :comments, :parent_id, :integer
    add_column :comments, :lft, :integer
    add_column :comments, :rgt, :integer
  end
end
