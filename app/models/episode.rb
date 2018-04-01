class Episode < ActiveRecord::Base
  belongs_to :podcast
  has_many :comments, dependent: :destroy
has_many :votes, dependent: :destroy
has_many :voted_by, through: :votes, source: :user

  mount_uploader :image, ImageUploader

  has_attached_file :mp3
  validates_attachment :mp3, :content_type => { :content_type => ["audio/mpeg", "audio/mp3"] }, :file_name => { :matches => [/mp3\Z/] }

  self.per_page = 15
end
