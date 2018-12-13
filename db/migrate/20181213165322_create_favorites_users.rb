class CreateFavoritesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites_users do |t|
      t.references :adder, index: true
      t.references :added, index: true

      t.timestamps
    end
  end
end
