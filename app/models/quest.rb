class Quest < ActiveRecord::Base
  belongs_to :admin
  belongs_to :language
  belongs_to :source
end
