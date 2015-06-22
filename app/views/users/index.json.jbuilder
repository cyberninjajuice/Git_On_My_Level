json.array!(@users) do |user|
  json.extract! user, :id, :created_at, :updated_at, :email
  json.url user_url(user, format: :json)
end
