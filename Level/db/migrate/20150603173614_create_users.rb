class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :github_digest
      t.string :rescue_digest

      t.timestamps null: false
    end
  end
end
