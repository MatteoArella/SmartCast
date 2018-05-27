class Episodes::EpisodesController < ApplicationController

	before_action :find_podcast # initialize @podcast variable
	before_action :find_artist  # initialize @artist variable

	load_and_authorize_resource :except => [:upvote, :downvote]

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

	def upvote 
	  @episode = Episode.find(episode_params_id) # episode_params_id abstract method defined into subclasses
	  @episode.upvote_by current_user
	  redirect_to :back
	end  

	def downvote
	  @episode = Episode.find(episode_params_id) # episode_params_id abstract method defined into subclasses
	  @episode.downvote_by current_user
	  redirect_to :back
	end

	private

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end

	def find_artist
		@artist = @podcast.artist
	end
end
