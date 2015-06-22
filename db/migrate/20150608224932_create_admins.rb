class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_digest
      t.string :tax_id
      t.boolean :non_profit

      t.timestamps null: false
    end
  end
end
