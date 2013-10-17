class AddModerationStateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :moderation_state, :string
  end
end
