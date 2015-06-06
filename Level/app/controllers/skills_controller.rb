class SkillsController < ApplicationController



  def index
    user = User.find(params[:user_id])
    user.initial_api
    user.skill_adding
    render json: user.skills
  end


  private

end
