class CreateMultipleUsersConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :multiple_users_conversations do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
