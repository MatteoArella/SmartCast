class Episodes::EpisodesController < ApplicationController

	before_action :find_podcast # initialize @podcast variable
	before_action :find_artist  # initialize @artist variable

	def index
		@episodes = @podcast.episodes
	end

	def edit
		@episode = Episode.find(params[:id])
		render template: "episodes/edit"
	end

	def update
		@episode = Episode.find(params[:id])

		if @episode.update(episode_params)
			redirect_to polymorphic_path([@podcast, @episode])
		else
			render 'edit'
		end
	end

	def destroy
		@episode = Episode.find(params[:id])
		@episode.destroy!
		flash[:notice] = "Successfully deleted episode"
		redirect_to podcast_path(@podcast.id)
	end


	private

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end

	def find_artist
		@artist = @podcast.artist
	end
end
