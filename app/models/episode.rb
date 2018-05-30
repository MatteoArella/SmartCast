class Episode < ActiveRecord::Base
  belongs_to :podcast
  #belongs_to :artist

  mount_uploader :image, ImageUploader

  validates :title, presence: :true
  validates :description, presence: :true
  validates :image, presence: :true

  acts_as_votable	  #make Episode class votable
  acts_as_commentable #make Episode class commentable

  self.per_page = 15
end
