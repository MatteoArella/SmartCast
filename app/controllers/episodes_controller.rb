class EpisodesController < ApplicationController

	before_action :find_podcast

	def index
		# @episodes = Episode.all
		@episodes = @podcast.episodes
	end

	def new
		@episode = Episode.new
	end

	def create
		#@episode = current_user.podcasts.create(podcast_params)
    	if @episode = podcast.episodes.create(episode_params)
    		flash[:success] = "Your episode was created!"
	      	redirect_to podcast_episode_path(@podcast, @episode)
	    else
	    	flash.notice = @episode.errors.full_messages.to_sentence
	    	redirect_to new_podcast_episode(@podcast)
	    end
	end

	def show
		render :plain => "episode show"
	end

	private
	def episode_params
		params.require(:episode).permit(:name, :description, :mp3, :image)
	end

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end
end
