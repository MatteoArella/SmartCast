class CommentsController < ApplicationController

	before_action :find_episode

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

	end

	def update

	end

	def edit

	end

	def destroy

	end

	private

	def find_episode
		@episode = Episode.find(params["#{params[:type].tableize.singularize}_id".to_sym])
	end

	def comment_params
		params.require(:comment).permit(:comment)
	end
end