class SitemapPinger 
  SEARCH_ENGINES = {
    google: "http://www.google.com/webmasters/tools/ping?sitemap=%s",
    bing: "http://www.bing.com/webmaster/ping.aspx?siteMap=%s"
  }

  def self.ping
    SitemapLogger.info Time.now
    SEARCH_ENGINES.each do |name, url|
      request = url % CGI.escape("http://www.agilesoft.es/sitemap.xml")  
      SitemapLogger.info "  Pinging #{name} with #{request}"

      #if Rails.env == "production"
        response = Net::HTTP.get_response(URI(request))
        SitemapLogger.info "    #{response.code}: #{response.message}"
        SitemapLogger.info "    Body: #{response.body}"
      #end
    end
  end
end