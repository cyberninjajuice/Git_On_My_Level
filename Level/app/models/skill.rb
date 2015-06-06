class Skill < ActiveRecord::Base
	belongs_to :user
	belongs_to :languages
  validates :language_id, presence: true, uniqueness: true
end
