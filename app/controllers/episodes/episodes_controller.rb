class Episodes::EpisodesController < ApplicationController

	before_action :find_podcast # initialize @podcast variable

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end
end
