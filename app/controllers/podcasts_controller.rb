class PodcastsController < ApplicationController
	
	def index
		@podcasts = Podcast.all
	end

	def new
		@podcast = Podcast.new
	end 

	def show
		@podcast = Podcast.find(params[:id])
		@artist = Artist.find(@podcast.artist_id)
	end



	def create
		@podcast = Podcast.new
		if (!params[:podcast][:name].present? or params[:podcast][:description].nil?)
        
      		flash[:danger] = "Error in creating the podcast!"
  			render 'new'
	  	else
	    	@podcast = current_user.podcasts.create(podcast_params)
	    	#@podcast.user_id= current_user.id
	    if @podcast.save
	    	flash[:success] = "Your podcast was created!"
	      	redirect_to podcast_path(@podcast)
	    end
	end


end	

private

  	def podcast_params
      	params.require(:podcast).permit(:name, :description)  
	end
end
