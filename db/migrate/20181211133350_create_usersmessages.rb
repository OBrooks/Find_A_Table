class CreateUsersmessages < ActiveRecord::Migration[5.2]
  def change
    create_table :usersmessages do |t|
      t.references :chatroom, foreign_key: true
      t.references :user, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end