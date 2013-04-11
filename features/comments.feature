@javascript
Feature: Post comment
	As a user
	In order I can post a comment
	I want to show the comment form

	Background:
		Given that I am on the homepage
		And there is one post in the blog
		When I click "show comment form" link

	Scenario: Show comment form
		Then I should see "#add_comentario"

	Scenario: Send comment
		And I fill in "author" with "Test"
		And I fill in "comment_content" with "Test comment"
		And I click "Enviar comentario" button
		Then I should see "#comments"
		And I should see "Test"
		And I should see "Test comment"