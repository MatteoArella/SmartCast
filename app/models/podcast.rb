class Podcast < ActiveRecord::Base

  PERMITTED_TYPES = ['AudioPodcast', 'VideoPodcast']

  def self.name_max_length
  	20
  end

  def self.description_max_length
  	100
  end

  validates :name, presence: :true, length: { maximum: name_max_length }
  validates :description, presence: :true, length: { maximum: description_max_length }

  validates :type, presence: :true
  validate :validate_type

  mount_uploader :image, ImageUploader

  validates :image, presence: :true

  belongs_to :artist
  has_many :episodes, dependent: :destroy

  self.per_page = 10

  private

  def validate_type
  	unless PERMITTED_TYPES.include? type
      errors.add(:type, :invalid)
    end
  end
end
