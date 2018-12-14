class CreateLikesToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :likes_to_users do |t|
      t.references :liker, index: true
      t.references :liked, index: true
      t.references :session, index: true

      t.timestamps
    end
  end
end
