class Podcast < ActiveRecord::Base
	belongs_to :artist
  has_many :episodes, dependent: :destroy

  mount_uploader :image, ImageUploader

  self.per_page = 10
end
