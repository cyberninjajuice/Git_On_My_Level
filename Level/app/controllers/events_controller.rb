class EventsController < ApplicationController
  def index
    # more error checking (500 error, etc)
    # json = JSON.parse(response.body)
    # json['url']
    user = User.find(params[:user_id])
    binding.pry
    api_url = "https://www.rescuetime.com/anapi/data?key=#{user.rescue_digest}&perspective=rank&restrict_kind=overview&restrict_thing=software%20development&restrict_begin=2015-05-01&format=json"
    
    response = HTTParty.get(api_url)
    rescuePusher(response, user)
    render json: response
  end
  private

  def rescuePusher(res, use)
      response = res["rows"]
      response.each do |act|
        #Get time in Minutes as uncut_EXP
        exp= math.round(act[1]/60)
        site= act[3]
        lang_id= Language.find_by(name: act[4]).id
        if (!lang_id.nil?)
          use.events.create(name: site, uncut_exp: exp, language_id: lang_id, source_id: 1)
        end
      end
  end
end
