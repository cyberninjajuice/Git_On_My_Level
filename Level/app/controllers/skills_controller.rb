class SkillsController < ApplicationController



  def index
    user = User.find(params[:user_id])

  end


  private

end
