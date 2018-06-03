class Episodes::VideoEpisodesController < Episodes::EpisodesController
	def new
		@episode = VideoEpisode.new
		render template: "episodes/new"
	end

	def create
		@episode = @podcast.episodes.create(episode_params)

		if @episode.errors.any?
			flash.notice = "Failed to Create Episode: <br/><br/>" + @episode.errors.full_messages.join("<br/>")
	    	redirect_to new_podcast_video_episode_path(@podcast.id)
		else
			flash.notice = "Episode Successfully Created"
			redirect_to podcast_video_episode_path(@podcast.id, @episode.id)
		end
	end

	private
	
	def episode_params
		params.require(:video_episode).permit(:title, :description, :image, :mp4).merge(:podcast_id => @podcast.id, :artist_id => @artist.id, :type => 'VideoEpisode')
	end

	def episode_params_id
		params[:video_episode_id]
	end

	# for show method
	def find_episode(params)
		VideoEpisode.find(params)
	end
end