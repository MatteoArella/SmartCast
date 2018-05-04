class Podcast < ActiveRecord::Base

  PERMITTED_TYPES = ['AudioPodcast', 'VideoPodcast']

  belongs_to :artist
  has_many :episodes, dependent: :destroy

  validates :name, presence: :true, length: { maximum: 20 }
  validates :description, presence: :true, length: { maximum: 100 }

  validates :type, presence: :true
  validate :validate_type

  mount_uploader :image, ImageUploader

  self.per_page = 10

  private

  def validate_type
  	unless PERMITTED_TYPES.include? type
      errors.add(:type, :invalid)
    end
  end
end
