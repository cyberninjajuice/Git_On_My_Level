class EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user.initial_api
    render json: user.events
  end

end
