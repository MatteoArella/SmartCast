class CommentsController < ApplicationController

	before_action :find_episode
	before_action :find_podcast

	def index
		
	end

	def new
		#@episode.comments.new
	end

	def create
		@comment = @episode.comments.create(comment_params)
		@comment.user_id = current_user.id
		@comment.save
		redirect_to :back
	end

	def show
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params)
			redirect_to polymorphic_path([@podcast, @episode])
		else
			if @comment.errors.any?
				flash.notice = "Failed to update comment: <br/><br/>" + @comment.errors.full_messages.join("<br/>")
	    		render template: 'comments/edit'
	    	end
		end
	end

	def edit
		@comment = Comment.find(params[:id])
		render template: 'comments/edit'
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to polymorphic_path([@podcast, @episode])
	end

	private

	def find_episode
		@episode = Episode.find(params["#{params[:type].tableize.singularize}_id".to_sym])
	end

	def find_podcast
		@podcast = Podcast.find(params[:podcast_id])
	end

	def comment_params
		params.require(:comment).permit(:comment)
	end
end