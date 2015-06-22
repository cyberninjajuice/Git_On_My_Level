class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.text :name
      t.text :color
      t.text :badge

      t.timestamps null: false
    end
  end
end
