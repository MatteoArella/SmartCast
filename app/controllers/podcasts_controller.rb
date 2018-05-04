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
		@podcast = podcast_create_from_params(params)

		if @podcast.nil?
			flash.notice = @podcast.errors.full_messages.to_sentence
	      	render 'new'
		else
			flash.notice = "Podcast Successfully Created"
			redirect_to podcast_path(@podcast)
		end
	end
end	

private

  	def podcast_params
      	params.require(:podcast).permit(:name, :description, :image, :type)  
	end

	def podcast_create_from_params(params)
		podcast = Podcast.new
		podcast.artist_id = current_user.id

		podcast.name = params[:name]
		podcast.description = params[:description]
		podcast.image = params[:image]
		podcast.type = params[:type]

		unless podcast.save
			nil
		else
			podcast
	end
end
