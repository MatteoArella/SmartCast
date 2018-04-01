class EpisodesController < ApplicationController

	before_action :find_podcast, only: [:show, :index, :create, :new]

	def index
		@episodes= Episode.all
	end

	def new
		@episode = @podcast.episodes.new
	end
	def show 
		@episode = Episode.find(params[:id])
		@comments = @episode.comments
	end
  def edit 
    @episode = Episode.find(params[:id])
  end

	def destroy
		
    		Episode.find(params[:id]).destroy
    		redirect_to root_path
  	end
  	def update
   	 @episode = Episode.find(params[:id])
    	if @episode.update_attributes(episode_params)
    	  
     	 redirect_to root_path
    	else
      		render 'edit'
   	 end
	  end

	def create
		@episode= Episode.new
		if (!params[:episode][:name].present? or params[:episode][:description].nil?)
        
      		flash[:danger] = "Error in creating the episode!"
  			render 'new'
	  	else
	    	#@episode = current_user.podcasts.create(podcast_params)
	    	#@episode = @podcast.episodes.create(episode_params)
	    	  	@podcast = Podcast.find(params[:podcast_id])
  				input = episode_params.merge(podcast: @podcast)
				@episode = @podcast.episodes.build(input)
	    	#@podcast.user_id= current_user.id
	    if @episode.save
	    	flash[:success] = "Your episode was created!"
	      	redirect_to root_path
	    end
	end
	
end



  def vote
    @episode = Episode.find(params[:id])
    type = params[:type]
    if type == "upvote"
      current_user.vottes << @episode
      #@episode.voted_by << current_user
      flash[:success] = "You favorited " + @episode.name
      redirect_to :back

    elsif type == "downvote"
      current_user.vottes.delete(@episode)
      #@episode.voted_by.delete(current_user)
      flash[:success] = "You unfavorited " + @episode.name
      redirect_to :back

    else
      # Type missing, nothing happens
      flash[:danger] = "Nothing happened"
      redirect_to :back
    end
  end


private
	def episode_params
		params.require(:episode).permit(:name, :description, :mp3, :image)
	end

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end
end
