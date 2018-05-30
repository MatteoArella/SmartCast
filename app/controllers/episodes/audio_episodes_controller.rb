class Episodes::AudioEpisodesController < Episodes::EpisodesController
	def new
		@episode = AudioEpisode.new
		render template: "episodes/new"
	end

	def create
		@episode = @podcast.episodes.create(episode_params)

		if @episode.errors.any?
			flash.notice = "Failed to Create Episode: <br/><br/>" + @episode.errors.full_messages.join("<br/>")
	    	redirect_to new_podcast_audio_episode_path(@podcast.id)
		else
			flash.notice = "Episode Successfully Created"
			redirect_to podcast_audio_episode_path(@podcast.id, @episode.id)
		end
	end

	def show
		@episode = AudioEpisode.find(params[:id])
		render template: "episodes/show"
	end

	private
	def episode_params
		params.require(:audio_episode).permit(:title, :description, :image, :mp3).merge(:podcast_id => @podcast.id, :artist_id => @artist.id, :type => 'AudioEpisode')
	end

	def episode_params_id
		params[:audio_episode_id]
	end
end