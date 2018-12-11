class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :user, index: true
      t.references :session, index: true
      t.integer :status, :default => 0
      t.timestamps
    end
  end
end
