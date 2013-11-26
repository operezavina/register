class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :level, :string
    add_column :users, :last, :string
    add_column :users, :company, :string
    add_column :users, :address, :string
    add_column :users, :zip, :string
    add_column :users, :phone, :string
    add_column :users, :fax, :string
    add_column :users, :description, :text

    add_index :users, :company
    add_index :users, :last
    add_index :users, :phone
  end
end
