Given /^that I am on the homepage$/ do
	visit root_path
end

Given /^there is one post in the blog$/ do
	if !Blog.first
		Blog.create! :author => "Test", :content => "Test post", :title => "Test post", :visible => true
	end
end

When /^I click "(.*)" link$/ do |id|
	click_link id.downcase.gsub!(" ","_")
end

When /^I click "(.*)" button$/ do |button|
	click_button button
end

When /^I fill in "(.*)" with "(.*)"$/ do |field,value|
	begin
		fill_in field, :with => value
	rescue Selenium::WebDriver::Error::ElementNotVisibleError => e
		fill_in_ckeditor field, :with => value
	end
end

Then /^I should see "(#|\.|)(.*)"$/ do |selector,value|
	if selector == "#"
		page.should have_css "##{value}"
	elsif selector == "."
		page.should have_css ".#{value}"
	else
		page.should have_content value
	end
end