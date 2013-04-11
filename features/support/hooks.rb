Before do
	Blog.create! :author => "Test", :content => "Testing", :title => "Test post", :visible => true
	User.create! :email => "test@test.com", :password => "123456", :password_confirmation => "123456"
end