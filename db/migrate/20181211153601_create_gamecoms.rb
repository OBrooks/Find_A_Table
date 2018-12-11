class CreateGamecoms < ActiveRecord::Migration[5.2]
  def change
    create_table :gamecoms do |t|
      t.text :content
      t.integer :score
      t.references :game, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
