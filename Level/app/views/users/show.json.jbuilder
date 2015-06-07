json.extract! @user, :id, :email, :created_at, :updated_at
  json.extract! @level_info if @user.rescue_key?