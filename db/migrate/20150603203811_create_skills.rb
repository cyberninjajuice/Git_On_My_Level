class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.text :user_id
      t.text :language_id
      t.text :experience

      t.timestamps null: false
    end
  end
end
