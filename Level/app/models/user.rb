class User < ActiveRecord::Base
	before_save :default_values
  has_many :authentications, :dependent => :destroy
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  

  has_many :skills
	has_many :languages, through: :skills
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
