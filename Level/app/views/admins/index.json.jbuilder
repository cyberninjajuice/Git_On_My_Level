json.array!(@admins) do |admin|
  json.extract! admin, :id, :email, :password_digest, :tax_id, :non_profit
  json.url admin_url(admin, format: :json)
end
