class EventsController < ApplicationController
  def index
    # more error checking (500 error, etc)
    # json = JSON.parse(response.body)
    # json['url']
    user = User.find(params[:user_id])
    #date
    rescueing=Time.now.to_s.split(" ")[0]
    formatted_date=user.last_rescued.strftime('%Y-%m-%d')
    formatted_date="2015-06-01"
    api_url = "https://www.rescuetime.com/anapi/data?key=#{user.rescue_key}&perspective=rank&restrict_kind=overview&restrict_thing=software%20development&restrict_begin=#{formatted_date}&restrict_end=#{rescueing}&format=json"
    
    response = HTTParty.get(api_url)
    if (rescueing != formatted_date)
    event=rescuePusher(response, user)
    user.update(last_rescued: rescueing)
    end
    render json: user.events
  end
  private

  def rescuePusher(res, use)
    respo = res["rows"]
    if(!respo.nil?&&respo.any?)
      respo.each do |act|
        #Get time in Minutes as uncut_EXP
        exp= act[1]/60
        site= act[3]
        lang= Language.where("name LIKE '#{act[4]}'")


        if (!lang.nil?&&lang.any?)
          use.events.create(
            name: site,
            uncut_exp: exp,
            language_id: lang[0].id,
            source_id: 1)
        end
      end
    end
  end

end
