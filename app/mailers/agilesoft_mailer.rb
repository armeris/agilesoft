class AgilesoftMailer < ActionMailer::Base
  default from: "comments@agilesoft.es"

  def comment_email(comment)
  	@comment = comment
  	mail(to: ENV['EMAIL_NOTIFICATION'], subject: "Nuevo comentario en #{comment.blog.title}")
  end
end
