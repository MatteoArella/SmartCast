class Episodes::VideoEpisodesController < Episodes::EpisodesController
	def index
		@episodes = @podcast.episodes
	end

	def new
		@episode = VideoEpisode.new
		render template: "episodes/new"
	end

	def create
		@episode = @podcast.episodes.create(episode_params.merge(:type => 'VideoEpisode'))

		if @episode.errors.any?
			flash.notice = "Failed to Create Episode: <br/><br/>" + @episode.errors.full_messages.join("<br/>")
	    redirect_to new_podcast_video_episode_path(@podcast.id)
		else
			@episode.podcast_id = @podcast.id
			@episode.save
			flash.notice = "Episode Successfully Created"
			redirect_to podcast_video_episode_path(@podcast.id, @episode.id)
		end
	end

	def show
		@episode = VideoEpisode.find(params[:id])
		render template: "episodes/show"
	end

	private
	def episode_params
		params.require(:video_episode).permit(:title, :description, :image, :mp4)
	end
end