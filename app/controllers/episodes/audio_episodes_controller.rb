class AudioEpisodesController < EpisodesController
	def index
		@episodes = @podcast.episodes
	end

	def new
		@episode = AudioEpisode.new
	end

	def create
		@episode = @podcast.episodes.create(episode_params)

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
		render :plain => "episode show"
	end

	private
	def episode_params
		params.require(episode_type).permit(attributes)
	end
end