class Podcast < ActiveRecord::Base
  belongs_to :artist
  has_many :episodes, dependent: :destroy

  
end
