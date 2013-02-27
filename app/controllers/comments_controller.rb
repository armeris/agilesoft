class CommentsController < ApplicationController
	def destroy
		if params[:id]
			@comment = Comment.find_by_id params[:id]
			if @comment
				@comment.deleted = true
				@comment.save
			end
		end
	end

	def create
		@comment = Comment.create author: params[:author], content: params[:comment][:content], blog_id: params[:post_id], deleted: false
	end
end