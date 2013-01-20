class BlogsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show, :about, :save_comment, :rss]

	def index
		@blog = Blog.where(visible: true).last
		@comment = Comment.new
		@old_posts = Blog.where(visible: true).sort{|a,b| b[:created_at]<=>a[:created_at]}
		if @blog
			@comments = @blog.comments.where(:deleted => false).sort{|a,b| a[:created_at]<=>b[:created_at]}
		else
			@comments = []
		end
	end

	def show
		@blog = Blog.find_by_id params[:post_id]
		@comment = Comment.new
		@old_posts = Blog.where(visible: true).sort{|a,b| b[:created_at]<=>a[:created_at]}
		@comments = @blog.comments.where(:deleted => false).sort{|a,b| a[:created_at]<=>b[:created_at]}
		render :index
	end

	def delete_post
		if params[:post_id]
			post = Blog.find_by_id params[:post_id]
			if post
				post.visible = false
				post.save
			end
		end

		redirect_to root_path
	end

	def delete_comment
		if params[:comment_id]
			@comment = Comment.find_by_id params[:comment_id]
			if @comment
				@comment.deleted = true
				@comment.save
			end
		end
	end

	def save_comment
		@comment = Comment.create author: params[:author], content: params[:comment][:content], blog_id: params[:post_id], deleted: false
	end

	def about
	end

	def create_post
		@blog = Blog.new
	end

	def save_post
		if !params[:post_id].nil? and !params[:post_id].empty?
			@blog = Blog.find params[:post_id]
		else
			@blog = Blog.new
		end
		
		@blog.author = params[:author]
		@blog.title = params[:title]
		@blog.content = params[:blog][:content]
		if !params[:post_id].nil? and !params[:post_id].empty?
			@blog.visible = true
		else
			@blog.visible = false
		end
		@blog.updated_at = somedate = DateTime.new(params[:blog]["updated_at(1i)"].to_i, 
                        params[:blog]["updated_at(2i)"].to_i,
                        params[:blog]["updated_at(3i)"].to_i,
                        params[:blog]["updated_at(4i)"].to_i,
                        params[:blog]["updated_at(5i)"].to_i)

		if !@blog.save
			if request.referrer.match /edit/
				render :edit_post
			elsif request.referrer.match /create/
				render :create_post
			end
		else
			if request.referrer.match /edit/
				redirect_to posts_path(:post_id => @blog.id)
			elsif request.referrer.match /create/
				redirect_to :action => :post_list
			end
		end
	end

	def edit_post
		@blog = Blog.find params[:post_id]
	end

	def post_list
		@list = Blog.all.sort{|a,b| b[:updated_at]<=>a[:updated_at]}
	end

	def visible_post
		post = Blog.find params[:post_id]
		post.record_timestamps = false
		post.visible = !post.visible
		post.save
		post.record_timestamps = true
		
		redirect_to :action => :post_list
	end

	def rss
    @posts =  Blog.where(:visible=>true).order("id desc").limit(10)
    
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end