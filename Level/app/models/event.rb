class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  belongs_to :source

  def github_hitter
    user = HTTParty.get "https://api.github.com/user", 
    :headers => { 
      "Authorization" => "token #{token}",
      "User-Agent" => "Git_On_My_Level"
    }
    puts "Hi, my username is #{user["login"]}"
  end

  def tot_exp
    (self.uncut_exp.to_i*self.source.exp_multiplier).to_i
  end
end