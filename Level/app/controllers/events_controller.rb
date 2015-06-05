class EventsController < ApplicationController
  def index
    # more error checking (500 error, etc)
    # json = JSON.parse(response.body)
    # json['url']
    user = User.find(params[:user_id])
    binding.pry
    api_url = "https://www.rescuetime.com/anapi/data?key=#{user.rescue_digest}&perspective=rank&restrict_kind=overview&restrict_thing=software%20development&restrict_begin=2015-05-01&format=json"
    
    response = HTTParty.get(api_url)
    event=rescuePusher(response, user)
    render json: user.events
  end
  private

  def rescuePusher(res, use)
      response = res["rows"]
      response.each do |act|
        #Get time in Minutes as uncut_EXP
        exp= act[1]/60
        site= act[3]
        lang= Language.where("name LIKE '#{act[4]}'")
        if (!lang.nil?&&lang.length>0)
          binding.pry
          use.events.create(name: site, uncut_exp: exp, language_id: lang.id, source_id: 1)
        end
      end
  end
end
