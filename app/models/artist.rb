class Artist < Learner
	has_many :podcasts, dependent: :destroy

	def artist?
    	true
  	end
end