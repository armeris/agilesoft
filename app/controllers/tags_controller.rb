class TagsController < ApplicationController

	before_filter :load_olposts_tags

	def tag_filter
		if params[:tags] and !params[:tags].empty?
			tag_list = params[:tags].split(',')
			@tag_filter = Tag.where(:name => tag_list.map{|t| t.downcase})
			@blogs = @tag_filter.map{|t| t.blogs}.inject(:&)
		else
			@tag_filter = []
			@blogs = Blog.where(:visible => true).order("created_at DESC")
		end
	end

	private

	def load_olposts_tags
  	@old_posts = Blog.where(visible: true).order("created_at DESC")
  	@tags = Tag.order("name ASC")
  end
end