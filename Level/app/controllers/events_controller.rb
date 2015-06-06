class EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user.initial_api
    fulleve = []
    user.events.each do |eve|
    fulleve << {
       id: eve.id,
       user_id: eve.user_id,
       name: eve.name,
       uncut_exp: eve.uncut_exp,
       tot_exp: eve.tot_exp.to_i,
       language: eve.language,
       source: eve.source,
       added_at: (eve.created_at).strftime("%m/%d/%Y")}
    end
    render json: fulleve
  end

end
