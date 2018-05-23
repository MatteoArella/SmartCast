class Podcast < ActiveRecord::Base

  PERMITTED_TYPES = ['AudioPodcast', 'VideoPodcast']

  def self.title_max_length
  	20
  end

  def self.description_max_length
  	100
  end

  validates :title, presence: :true, length: { maximum: title_max_length }
  validates :description, presence: :true, length: { maximum: description_max_length }

  validates :type, presence: :true
  validate :validate_type

  mount_uploader :image, ImageUploader

  validates :image, presence: :true

  belongs_to :artist

  acts_as_votable

  self.per_page = 10

  def video?
    false
  end

  def audio?
    false
  end

  def self.find_by_title(title)
    Podcast.where("title LIKE ?", "%#{sanitize_sql_like(title)}%")
  end

  private

  def validate_type
  	unless PERMITTED_TYPES.include? type
      errors.add(:type, :invalid)
    end
  end
end
