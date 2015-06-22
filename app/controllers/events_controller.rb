class EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user.initial_api
    full_eve = []
    user.events.each do |eve|
    full_eve << {
       id: eve.id,
       user_id: eve.user_id,
       name: eve.name,
       uncut_exp: eve.uncut_exp,
       tot_exp: eve.tot_exp.to_i,
       language: eve.language,
       source: eve.source,
       added_at: (eve.created_at).strftime("%m/%d/%Y")}
    end
    render json: full_eve
  end

end
