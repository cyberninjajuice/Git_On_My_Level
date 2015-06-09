class Admin < ActiveRecord::Base
  has_secure_password
  has_many :quests
  
  VALIDEMAIL = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  before_save {self.email = email.downcase}
  validates :email,
  presence: true, 
  length: { minimum: 5, maximum: 200},
  format: { with: VALIDEMAIL }, 
  uniqueness: { case_sensitive: false}

  validates :password, 
    length: {
    minimum: 5,
    maximum: 200 }, 
    allow_blank: true
end
