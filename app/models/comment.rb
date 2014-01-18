class Comment < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :author, :content, :deleted, :blog_id, :remote_ip, :user_agent, :referrer
  validates :author, :presence => true
  validates :content, :presence => true

  after_validation :check_spam


  private

  def check_spam
  	client = Akismet::Client.new( 'your-api-key',
  		'http://www.agilesoft.es',
  		:app_name => 'agilesoft.es',
  		:app_version => '1.0' )

  	spam = client.comment_check(self.remote_ip,
  											self.user_agent,
  											content_type: 'comment',
  											referrer: self.referrer,
  											permalink: "http://www.agilesoft.es/posts/#{blog.id}",
  											comment_author: self.author,
  											comment_content: self.content)
  	
  	self.deleted = spam if spam
  end
end
