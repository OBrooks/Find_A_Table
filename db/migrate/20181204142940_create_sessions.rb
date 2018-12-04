class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :host, index: true
      t.references :game, index: true
      t.date :date
      t.string :city
      t.string :adress
      t.text :descritpion
      t.integer :playernb
      t.integer :maxplayers
      t.integer :status, :default => 0
      t.integer :playerskill, :default => 0
      t.timestamps
    end
  end
end
