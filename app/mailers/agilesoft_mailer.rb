class AgilesoftMailer < ActionMailer::Base
  default from: "from@example.com"

  def comment_email(comment)
  	@comment = comment
  	mail(to: ENV['EMAIL_NOTIFICATION'], subject: "Nuevo comentario en #{comment.blog.title}")
  end
end
