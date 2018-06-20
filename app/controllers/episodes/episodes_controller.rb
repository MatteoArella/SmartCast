class Episodes::EpisodesController < ApplicationController

	before_action :find_podcast # initialize @podcast variable
	before_action :find_artist  # initialize @artist variable

	load_and_authorize_resource param_method: :episode_params, except: [:create, :upvote, :downvote, :comment, :facebook_share]

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

	def show
		@episode = find_episode(params[:id])
		@comment = @episode.comments.new
		render template: "episodes/show"
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

	def facebook_share
		if current_user.identities.where(provider: 'facebook').first.nil?
			redirect_to user_facebook_omniauth_authorize_path
		end

		access_token = current_user.identities.where(provider: 'facebook').first.token
		@episode = Episode.find(episode_params_id)
		@graph = FacebookController.get_graph(access_token)
		begin
			@graph.put_wall_post("#{@episode.title},\n #{@episode.description}", {
				"name" => @episode.title,
				"link" => polymorphic_path([@podcast, @episode]),
				"description" => @episode.description,
				"picture" => @episode.image.url
				})
		rescue Koala::Facebook::APIError => e
			if(e.fb_error_type == "OAuthException")
		    flash["notice"] = e.fb_error_message
		  end
		end
		redirect_to :back
	end

	private

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end

	def find_artist
		@artist = @podcast.artist
	end

	def comments_params
		params.require(:comment).permit(:comment)
	end
end
