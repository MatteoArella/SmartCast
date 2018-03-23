class EpisodesController < ApplicationController

	before_action :find_podcast

	def index
		@episodes= Episode.all
	end

	def new
		@episode= Episode.new
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

private
	def episode_params
		params.require(:episode).permit(:title, :description, :mp3)
	end

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end
end
