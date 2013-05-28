Feature: Add tags
	As admin user
	In order I can organize blog posts
	I want to add tags to blog posts

	Scenario: I have a field with tags in blog creation page
		Given that there is one admin user
		And I am logged in as admin user
		And that I am on the homepage
		When I click "Nuevo post" link
		Then I should see a "tags" field

	Scenario: I can create a post with tags
		Given that there is one admin user
		And I am logged in as admin user
		And that I am on the homepage
		When I click "Nuevo post" link
		And I fill "author" with "Test"
		And I fill "title" with "Test Title"
		And I fill "content" with "Test post"
		And I fill "tags" with "ruby, heroku"
		And I click "Guardar" button
		And I visit last blog 
		Then I should see ".tag"
		And I should see "Ruby"
		And I should see "Heroku"
	
	Scenario: I have a field with tags in blog editing page
		Given that there is one admin user
		And there is one post in the blog
		And I am logged in as admin user
		And that I am on the homepage
		When I click "edit post" link
		Then I should see a "tags" field

	Scenario: I can modify current post tags
		Given that there is one admin user
		And there is one post in the blog
		And I am logged in as admin user
		And that I am on the homepage
		When I click "edit post" link
		And I fill "tags" with "ruby, heroku"
		And I click "Guardar" button
		Then I should see "#tags"
		Then I should see ".tag"
		And I should see "Ruby"
		And I should see "Heroku"