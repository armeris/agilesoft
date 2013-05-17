class BlogsController < ApplicationController
	protect_from_forgery
	
	before_filter :authenticate_user!, :except => [:index, :show, :about, :save_comment, :rss]
	before_filter :load_oldposts_tags, :only => [:index, :show]

	def index
		@blog = Blog.includes(:tags).where(visible: true).last
		if @blog
			@comments = @blog.comments.where(:deleted => false).order("created_at ASC")
		else
			@comments = []
		end
	end

	def show
		@blog = Blog.includes(:tags).find_by_id params[:post_id]
		if @blog
			@comments = @blog.comments.where(:deleted => false).order("created_at ASC")
		else
			@comments = []
		end
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
		@blog.tags.clear
		params[:tags].split(",").each do |item|
			tag = Tag.where(name: item.downcase.strip).first
			if !tag
				tag = Tag.create! name: item.downcase.strip
			end
			@blog.tags << tag
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
		@list = Blog.order("updated_at DESC")
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

  private

  def load_oldposts_tags
  	@comment = Comment.new
  	@old_posts = Blog.where(visible: true).order("created_at DESC")
  	@tags = Tag.order("name ASC")
  end

end