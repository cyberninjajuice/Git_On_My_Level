json.array!(@ongoing_quests) do |ongoing_quest|
  json.extract! ongoing_quest, :id, :quest_id, :user_id
  json.url ongoing_quest_url(ongoing_quest, format: :json)
end
