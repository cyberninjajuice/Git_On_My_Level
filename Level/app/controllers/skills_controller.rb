class SkillsController < ApplicationController



  def index
    user = User.find(params[:user_id])

  end


  private
  def all_language_events(use)
    langs = []
    use.events.each do |eve|
      langs << eve.language
    end
    langs.uniq
  end
  binding.pry

end
