class SkillsController < ApplicationController



  def index
    user = User.find(params[:user_id])
    user.skill_adding
    render json: user.skills
  end


  private

end
