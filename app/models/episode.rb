class Episode < ActiveRecord::Base
  belongs_to :podcast

  mount_uploader :image, ImageUploader

  validates :title, presence: :true
  validates :description, presence: :true
  validates :image, presence: :true

  self.per_page = 15
end
