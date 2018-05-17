class PodcastsController < ApplicationController
	#before_filter :podcast_params_filter, :only => [:create, :update]
	
	load_and_authorize_resource param_method: :podcast_params, :except => [:upvote, :downvote]
	
	def index
		unless podcast_search_params[:search].nil?
			@podcasts = Podcast.find_by_title(params[:search]).order(:cached_votes_up => :desc).paginate(:page => params[:page])
		else
			@podcasts = Podcast.order(:cached_votes_up => :desc).paginate(:page => params[:page])
		end
	end

	def new
		@podcast = Podcast.new
	end

	def create
		@podcast = Podcast.create(podcast_params)

		if @podcast.errors.any?
			flash.notice = "Failed to Create Podcast: <br/><br/>" + @podcast.errors.full_messages.join("<br/>")
	    redirect_to new_podcast_path
		else
			@podcast.artist_id = current_user.id
			@podcast.save
			flash.notice = "Podcast Successfully Created"
			redirect_to podcast_path(@podcast)
		end
	end

	def show
		@podcast = Podcast.find(params[:id])
		@artist = Artist.find(@podcast.artist_id)
		@episodes = @podcast.episodes.paginate(:page => params[:page])
	end

	def edit
		@podcast = Podcast.find(params[:id])
	end

	def update
		@podcast = Podcast.find(params[:id])

		if @podcast.update(podcast_params)
			redirect_to @podcast.becomes(Podcast)
		else
			render 'edit'
		end
	end

	def destroy
		@podcast = Podcast.find(params[:id])
		@podcast.destroy!
		flash[:notice] = "Successfully deleted podcast"
		redirect_to root_path
	end

	def upvote 
	  @pod = Podcast.find(params[:id])
	  @pod.upvote_by current_user
	  redirect_to :back
	end  

	def downvote
	  @podcast = Podcast.find(params[:id])
	  @podcast.downvote_by current_user
	  redirect_to :back
	end

	private

	def podcast_search_params
		params.permit(:search)
	end

	def podcast_params
    	params.require(:podcast).permit(:title, :description, :image, :type)
	end
end
