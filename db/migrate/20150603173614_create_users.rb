class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :github_key
      t.string :rescue_key
      t.integer :logins
      t.timestamp :last_rescued
      t.timestamps null: false
    end
  end
end
