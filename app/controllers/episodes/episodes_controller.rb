class Episodes::EpisodesController < ApplicationController

	before_action :find_podcast # initialize @podcast variable
	before_action :find_artist  # initialize @artist variable

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end

	def find_artist
		@artist = @podcast.artist
	end
end
