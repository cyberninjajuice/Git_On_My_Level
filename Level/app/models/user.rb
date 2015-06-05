class User < ActiveRecord::Base
	has_many :skills
	has_many :languages, through: :skills
  has_many :authentications, :dependent => :destroy
  has_many :events
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  attr_accessor :rescue

  accepts_nested_attributes_for :authentications
  validates :email,
   presence: true,
   uniqueness: true

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end

end
