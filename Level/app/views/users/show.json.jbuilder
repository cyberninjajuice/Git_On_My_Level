json.extract! @user, :id, :email, :logins, :last_rescued, :created_at, :updated_at
json.extract! @level_info, :name, :level, :next_level, :exp_left, :next_requires, :exp if @user.rescue_key?