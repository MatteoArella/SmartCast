class PodcastsController < ApplicationController
	
	def index
		@podcasts = Podcast.paginate(:page => params[:page])
	end

	def new
		@podcast = Podcast.new
	end 

	def show
		@podcast = Podcast.find(params[:id])
		@artist = Artist.find(@podcast.artist_id)
		@episodes = @podcast.episodes.paginate(:page => params[:page])
	end



	def create
		@podcast = podcast = Podcast.create(podcast_params)

		if @podcast.errors.any?
			flash.notice = @podcast.errors.full_messages.to_sentence
	      	render 'new'
		else
			@podcast.artist_id = current_user.id
			@podcast.save
			flash.notice = "Podcast Successfully Created"
			redirect_to podcast_path(@podcast)
		end
	end

	private

  	def podcast_params
      	params.require(:podcast).permit(:name, :description, :image, :type)  
	end
end
