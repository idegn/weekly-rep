class NotificationMailer < ApplicationMailer
  default from: 'weekly-rep@example.com'

  def notification_mail(user)
    @user = user
    mail to: @user.email, subject: '週報を書きましょう'
  end

  def write_notification(write_user, user)
    @write_user = write_user
    mail to: user.email, subject: "#{write_user.name}さんが週報を書きました"
  end

  def comment_notification(comment, user)
    @comment = comment
    mail to: user.email, subject: "#{@comment.user.name}さんがコメントしました"
  end
end
