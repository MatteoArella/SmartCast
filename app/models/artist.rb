class Artist < Learner
	has_many :podcasts, dependent: :destroy
	has_many :episodes, :through => :podcasts

	def artist?
    true
  end
end