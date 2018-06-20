class FacebookController
	def self.get_graph(access_token)
		Koala::Facebook::API.new(access_token)
	end
end