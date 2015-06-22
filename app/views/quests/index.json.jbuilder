json.array!(@quests) do |quest|
  json.extract! quest, :id, :name, :bounty, :link, :quantity, :language_id, :source_id, :admin_id
  json.url quest_url(quest, format: :json)
end
