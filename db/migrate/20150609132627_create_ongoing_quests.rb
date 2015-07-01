class CreateOngoingQuests < ActiveRecord::Migration
  def change
    create_table :ongoing_quests do |t|
      t.integer :quest_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
