# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def notification_mail
    NotificationMailer.notification_mail(User.find(2))
  end
end
