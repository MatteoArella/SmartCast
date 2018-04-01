class PodcastsController < ApplicationController




def index
  if params[:search]
@search = params[:search]
    #@podcasts = Podcast.where(:name => :search ).paginate(:page => params[:page], :per_page => 50)
  end

    @podcasts = Podcast.paginate(:page => params[:page], :per_page => 50)
    
end


	def edit
		@podcast = Podcast.find(params[:id])
	end

	def update

		@podcast= Podcast.find(params[:id])
		
		if @podcast.update_attributes(podcast_params)
			flash[:success]= "Podcast updated"
			redirect_to root_path

		else
			render 'edit'
		end

	
	end


	def new
		@podcast = Podcast.new
	end 

	def show
		@podcast = Podcast.find(params[:id])
		@artist = Artist.find(@podcast.artist_id)
		@episodes = @podcast.episodes.paginate(:page => params[:page])
	end

	def destroy
		
    		Podcast.find(params[:id]).destroy
    		redirect_to root_path
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
      	params.require(:podcast).permit(:name, :description, :image, :search)  
	end
end
