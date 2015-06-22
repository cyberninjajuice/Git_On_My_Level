class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.integer :bounty
      t.string :link
      t.integer :quantity
      t.integer :language_id
      t.integer :source_id
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
