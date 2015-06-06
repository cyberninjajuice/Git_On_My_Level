class User < ActiveRecord::Base
	before_save :default_values
  has_many :authentications, :dependent => :destroy
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  
  has_many :skills
	has_many :languages, through: :events
  has_many :events


  accepts_nested_attributes_for :authentications

  validates :email,
   uniqueness: true

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end

  def events_getter

  end
  def default_values
    self.logins = 0 if self.logins.nil?
  end

  def initial_api
    rescueing=Time.now.to_s.split(" ")[0]
    if (self.last_rescued.nil?)
      formatted_date = "2015-04-01"
    else
      formatted_date = self.last_rescued.strftime('%Y-%m-%d')
    end    
    api_url = "https://www.rescuetime.com/anapi/data?key=#{self.rescue_key}&perspective=rank&restrict_kind=overview&restrict_thing=software%20development&restrict_begin=#{formatted_date}&restrict_end=#{rescueing}&format=json"
    if (rescueing != formatted_date)
    response = HTTParty.get(api_url)
    self.rescue_pusher(response)
    self.update(last_rescued: rescueing)
    end
  end   

  def rescue_pusher(res)
    respo = res["rows"]
    if(!respo.nil?&&respo.any?)
      respo.each do |act|
        #Get time in Minutes as uncut_EXP
        exp= act[1]/60
        site= act[3]
        lang= Language.where("name LIKE '#{act[4]}'")

        if (!lang.nil?&&lang.any?)
          self.events.create(
            name: site,
            uncut_exp: exp,
            language_id: lang[0].id,
            source_id: 1)
        end
      end
    end
  end

  #add 

  #Ensure we are not missing skills
  def skill_adding
    langs = self.language_ids
    #are there supposed to be skills?
    if (langs.any?)
      #are there?
      if (!self.skills.any?)
      #add the missing skills
      langs.each do |lan|
        self.skills.create(
        language_id: lan, 
        experience: self.final_total(lan))
      end
      elsif (self.skills.length< langs)
      end


      end
    end
    langs.uniq
  end
  
  #get all the languages associated with a language
  def language_ids
    langs = []
    if (self.languages.any?)
      self.languages.each do |lan|
        langs << lan.id
      end
    langs.uniq
    end
  end

  def final_total(lang)
    total_exp=0
    if(self.events.any?)

      self.events.each do |eve|
        if(eve.language_id==lang_id)
          total_exp += eve.tot_exp
        end
      end
    end
    total_exp
  end

end