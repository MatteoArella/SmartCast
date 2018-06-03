class VideoEpisode < Episode
	has_attached_file :mp4
  validates_attachment :mp4, :content_type => { :content_type => ["video/mp4"] }, :file_name => { :matches => [/mp4\Z/] }
  validates :mp4, presence: :true
end