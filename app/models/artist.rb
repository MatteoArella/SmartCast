class Artist < User
	has_many :podcasts, dependent: :destroy
end