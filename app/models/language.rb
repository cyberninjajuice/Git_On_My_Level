class Language < ActiveRecord::Base
	has_many :skills
  has_many :events
end