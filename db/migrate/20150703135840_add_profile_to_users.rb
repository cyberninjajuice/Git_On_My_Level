class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
    add_column :users, :name, :string
    add_column :users, :admin, :boolean, default: :false
  end
end
