xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
	@static_paths.each do |path|
		xml.url do
			xml.loc "http://www.agilesoft.es#{path}"
			xml.changefreq("never")
		end
	end
	@posts.each do |post|
		xml.url do
			xml.loc "http://www.agilesoft.es/posts/#{post.id}"
			xml.lastmod post.updated_at.strftime("%F")
			xml.changefreq("monthly")
		end
	end
end