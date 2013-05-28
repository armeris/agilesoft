Feature: Post comment
	As a user
	In order I can post a comment
	I want to show the comment form

	Background:
		Given that I am on the homepage
		And there is one post in the blog

	Scenario: Send comment
		And I fill in "comment_author" with "Test"
		And I fill in "comment_content" with "Test comment"
		And I click "Enviar comentario" button
		Then I should see "Comentario guardado correctamente"
		And I should see "Test"
		And I should see "Test comment"

	Scenario: Bot comment
		And I fill in "comment_author" with "Test"
		And I fill in "comment_content" with "Test comment"
		And I fill in "comment_mandatory" with "Test bot"
		And I click "Enviar comentario" button
		Then I should see "Error guardando comentario"