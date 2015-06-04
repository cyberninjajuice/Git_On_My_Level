class StaticPagesController < ApplicationController
  file= File.read("rescueSecret.json")
  data= JSON.parse(file)
  apiKey=data["secret"]
  puts apiKey
API_URL = "https://www.rescuetime.com/anapi/data?key=#{apiKey}&perspective=rank&restrict_kind=overview&restrict_thing=software%20development&restrict_begin=2015-05-01&restrict_end=2015-05-07&format=json"
	
    def home
    response = HTTParty.get(API_URL)
    # more error checking (500 error, etc)
    json = JSON.parse(response.body)
    json['url']

  end
end