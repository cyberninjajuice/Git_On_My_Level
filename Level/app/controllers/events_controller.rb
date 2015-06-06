class EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user.initial_api
    fulleve = []
    user.events.each do |eve|
    fulleve << {id: eve.id,
       name: eve.name,
       uncut_exp: eve.uncut_exp,
       language: eve.language,
       source: eve.source,
       added_at: (eve.created_at).strftime("added on %m/%d/%Y")}
    end
    render json: fulleve
  end

end
