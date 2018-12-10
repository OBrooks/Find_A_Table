class CreateFavoritesGamesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :game, index: true
      t.timestamps
    end
  end
end
