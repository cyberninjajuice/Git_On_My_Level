class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.integer :user_id
      t.text :uncut_exp
      t.integer :language_id
      t.integer :source_id

      t.timestamps null: false
    end
  end
end
