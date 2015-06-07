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
    if(!respo.nil? && respo.any?)
      respo.each do |act|
        #Get time in Minutes as uncut_EXP
        exp= act[1]/60
        site= act[3]
        lang= Language.where("name LIKE '#{act[4]}'")

        if (!lang.nil? && lang.any?)
          self.events.create(
            name: site,
            uncut_exp: exp,
            language_id: lang[0].id,
            source_id: 1)
        end
      end
    end
  end

  #add missing only
  def add_missing(set_of_lang_ids)
    set_of_lang_ids.each do |lan|
      self.skills.create(
      language_id: lan, 
      experience: self.final_total(lan))
    end
  end
  #update all the duplicates
  def update_replicates(set_of_lang_ids)
    set_of_lang_ids.each do |lan|
      Skill.find_by(language_id: lan).update(
        experience: self.final_total(lan))
    end
  end
  #Ensure we are not missing skills
  def skill_adding
    langs = self.language_ids
    #are there supposed to be skills?
    if (!langs.nil? && langs.any?)
      #are there?
      if (!self.skills.any?)
        #add all languages if none.
        add_missing(langs)
      else
        #sort replicates vs missing ones
        add_these = langs-self.skill_lids
        update_these = (langs & self.skill_lids)
        if(add_these.any?)
          add_missing(add_these)
        end
        if(update_these.any?)
          update_replicates(update_these)
        end

      end
    end
  end
  
  def skill_lids
    skills = []
    if (self.skills.any?)
      self.skills.each do |skill|
        skills << skill.language_id.to_i
      end
      skills.uniq
    end
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

  def final_total(lang_id)
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