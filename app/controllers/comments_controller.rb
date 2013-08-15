class CommentsController < ApplicationController

	before_action :require_current_user

	def create
		@comment = Comment.new(comment_params)
		@comment.commentable = Photo.find(params[:photo_id])
		@comment.user = @current_user
		@comment.save

		redirect_to @comment.commentable
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
