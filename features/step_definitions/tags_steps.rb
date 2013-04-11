Given /^that there is one admin user$/ do
	if !User.first
		User.create! :email => "test@test.com", :password => "123456", :password_confirmation => "123456"
	end
end

Given /^I am logged in as admin user$/ do
	visit "/users/sign_in"
	fill_in "user_email", :with => "test@test.com"
	fill_in "user_password", :with => "123456"
	click_button "Sign in"
end

Then /^I should see a "(.*)" field$/ do |field|
	page.should have_field field
end

When /^I fill "(.*)" with "(.*)"$/ do |field,value|
	fill_in field, :with => value
end

When /^I visit last blog$/ do
	visit "/posts/#{Blog.last.id}"
end