class HomeController < ApplicationController
	protect_from_forgery

	before_filter :authenticate_user!, :only => [:ping]

	
	def about
	end

	def sitemap
		@static_paths = [ about_path ]
		@posts = Blog.where(visible: true).order("created_at ASC")
		respond_to do |format|
			format.xml
		end
	end

	def ping
		SitemapPinger.ping
		redirect_to root_path
	end
end