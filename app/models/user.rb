class User < ActiveRecord::Base
	before_save :default_values
  attr_accessor :remember_token
  before_save {self.email = email.downcase}
  has_many :authentications, :dependent => :destroy
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_secure_password validations: false
  has_many :skills
	has_many :languages, through: :events
  has_many :events
  has_many :ongoing_quests
  has_many :quests, through: :ongoing_quests
  has_many :admins, through: :quests

  accepts_nested_attributes_for :authentications

  #regex for vaild email A-z at least 1 char then @ symbol then at least 1 letter then a dot then at least 1 letter..
  VALIDEMAIL = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  #name must be at least 3 chars and up to 50...
  validates :name, length: { minimum: 5, maximum: 50 }, allow_blank: true
  #email... uses regex, minlength 5 max 200, casesensitive false
  validates :email, presence: false, allow_blank: true,
  length: { minimum: 5, maximum: 200},
  format: { with: VALIDEMAIL },
  uniqueness: { case_sensitive: false}
  #min 5 -max 200  for password
  #ensure that updating allows for no password insertion.
  validates :password, presence: false

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end

  def events_getter

  end

  def has_rescue
    (self.rescue_key? && self.rescue_key.length == 40)
  end

  def default_values
    self.logins = 0 if self.logins.nil?
  end

  def initial_api
    if (self.has_rescue)
    rescueing = Time.now.to_s.split(" ")[0]
    if (self.last_rescued.nil?)
      formatted_date = "2015-04-01"
    else
      formatted_date = self.last_rescued.strftime("%Y-%m-%d")
    end    

    api_url = "https://www.rescuetime.com/anapi/data?key=#{self.rescue_key}&perspective=rank&restrict_kind=overview&restrict_thing=software%20development&restrict_begin=#{formatted_date}&restrict_end=#{rescueing}&format=json"
    if (rescueing != formatted_date || !self.events.any? )
      response = HTTParty.get(api_url)
      if(!response.nil? && response && response.length> 0)
        self.rescue_pusher(response)
        self.update(last_rescued: rescueing)
      end
      end
    end
  end   

  def rescue_pusher(res)
    respo = res["rows"]
    if(!respo.nil? && respo.any?)
      respo.each do |act|
        #Get time in Minutes as uncut_EXP
        exp = act[1]/60
        site = act[3]
        lang = Language.where("name LIKE '#{act[4]}'")

        if (!lang.nil? && lang.any?)
          self.events.create!(
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
      self.skills.create!(
      language_id: lan, 
      experience: self.final_total(lan))
    end
  end
  #update all the duplicates
  def update_replicates(set_of_lang_ids)
    set_of_lang_ids.each do |lan|
      self.skills.find_by(language_id: lan).update(
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
  def grand_total_exp
    grand_total = 0
    if (self.skills.any?)
      self.skills.each {
        |skill| grand_total += skill.experience.to_i
      }
    end
    grand_total
  end

  def get_grand_level
    level = 0
    multiplier = 2000
    exp = self.grand_total_exp.to_i
    exp_needed = 2000
    while (exp - exp_needed > 0)
      #follows geometric Function to calculate current Level
      exp_needed = (multiplier*2**level)
      level += 1
    end
    
    {level: level, next_level: level+1, next_requires: exp_needed, exp_left: exp_needed-exp, exp: exp, level_percent: (exp/exp_needed*100), guild: self.get_guild_rank(level) }
  end

  def get_guild_rank(lvl)
    if(lvl < 5)
      rank = "Beginner"
    elsif(lvl < 10)
      rank = "Novice"
    elsif(lvl < 15)
      rank = "Apprentice"
    elsif(lvl < 20)
      rank = "Journeymen"
    elsif(lvl < 25)
      rank = "Master"
    elsif(lvl < 30)
      rank = "Grand-Master"
    else
      rank = "Arcane Grand-Master of the Keyboard"
    end
    rank
  end

  def final_total(lang_id)
    total_exp = 0
    if(self.events.any?)

      self.events.each do |eve|
        if(eve.language_id ==lang_id)
          total_exp += eve.tot_exp
        end
      end
    end
    total_exp
  end

end