class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :town, :string
    add_column :users, :adress, :text
    add_column :users, :status, :integer
    add_column :users, :gender, :string
    add_column :users, :experience, :integer
    add_column :users, :description, :text
  end
end
