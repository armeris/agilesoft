class CommentsController < ApplicationController
	protect_from_forgery
	
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
		comment = Comment.create author: params[:comment][:author], content: params[:comment][:content], blog_id: params[:post_id], deleted: false
		if comment.errors.empty? and params[:comment][:mandatory].empty?
			redirect_to "#{posts_path(:post_id => params[:post_id])}#comments", :notice => "Comentario guardado correctamente"
		else
			redirect_to "#{posts_path(:post_id => params[:post_id])}#form_comentario", :alert => "Error guardando comentario"
		end
	end
end