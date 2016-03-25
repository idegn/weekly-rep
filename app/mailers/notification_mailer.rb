class NotificationMailer < ApplicationMailer
  default from: 'weekly-rep@example.com'

  def notification_mail(user)
    @user = user
    mail to: @user.email, subject: '週報を書きましょう'
  end
end
