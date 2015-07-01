class SkillsController < ApplicationController

  def index
    user = User.find(params[:user_id])

    user.initial_api
    user.skill_adding
    full_skill = []
    if user.skills.any?
      user.skills.each do |skill|
        full_skill << {
          id: skill.id,
          user_id: skill.user_id,
          old_exp: skill.previous_exp,
          exp: skill.experience,
          language: skill.language,
          updated_at: (skill.updated_at).strftime("%m/%d/%Y"),
          added_at: (skill.created_at).strftime("%m/%d/%Y"),
          level_info: skill.get_level
        }
    
      end
      render json: full_skill
    else
      render json: []
    end
  end


  private

end
