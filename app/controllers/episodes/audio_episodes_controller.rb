class Episodes::AudioEpisodesController < EpisodesController
	def index
		@episodes = @podcast.episodes
	end

	def new
		@episode = AudioEpisode.new
	end

	def create
		@episode = @podcast.episodes.create(episode_params.merge(:type => 'AudioEpisode'))

		if @episode.errors.any?
			flash.notice = "Failed to Create Episode: <br/><br/>" + @episode.errors.full_messages.join("<br/>")
	    redirect_to new_podcast_audio_episode_path(@podcast.id)
		else
			@episode.podcast_id = @podcast.id
			@episode.save
			flash.notice = "Episode Successfully Created"
			redirect_to podcast_audio_episode_path(@podcast.id, @episode.id)
		end
	end

	def show
		@episode = AudioEpisode.find(params[:id])
		render :json => @episode
	end

	private
	def episode_params
		params.require(:audio_episode).permit(:title, :description, :image, :mp3)
	end
end