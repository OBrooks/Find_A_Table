class CreateCryptomons < ActiveRecord::Migration[5.2]
  def change
    create_table :cryptomons do |t|
      t.string :name
      t.string :value
      t.timestamps
    end
  end
end
