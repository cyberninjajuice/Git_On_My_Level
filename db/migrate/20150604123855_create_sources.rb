class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :name
      t.decimal :exp_multiplier
      t.text :logo

      t.timestamps null: false
    end
  end
end
