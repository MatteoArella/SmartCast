class Podcast < ActiveRecord::Base

  PERMITTED_CATEGORIES = ['AudioPodcast', 'VideoPodcast']

  def self.title_max_length
  	20
  end

  def self.description_max_length
  	100
  end

  validates :title, presence: :true, length: { maximum: title_max_length }
  validates :description, presence: :true, length: { maximum: description_max_length }

  validates :category, presence: :true
  validate :validate_category

  mount_uploader :image, ImageUploader

  validates :image, presence: :true

  belongs_to :artist
  has_many :episodes

  acts_as_votable

  self.per_page = 10

  def video?
    category.eql? "VideoPodcast"
  end

  def audio?
    category.eql? "AudioPodcast"
  end

  def self.find_by_title(title)
    Podcast.where("title LIKE ?", "%#{sanitize_sql_like(title)}%")
  end

  private

  def validate_category
  	unless PERMITTED_CATEGORIES.include? category
      errors.add(:category, :invalid)
    end
  end
end
