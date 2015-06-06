class Skill < ActiveRecord::Base
	belongs_to :user
	belongs_to :language
  validates :language_id, presence: true, uniqueness: true
  before_update :previous_exp
  before_save :default_exp

  def previous_exp
    prev = self.experience if self.experience_changed?
  end

  def default_exp
    self.experience = 0 if self.experience.nil?
  end
end
