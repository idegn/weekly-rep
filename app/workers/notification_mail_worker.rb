class NotificationMailWorker
  include Sidekiq::Worker

  def perform(klass, id)
    object = klass.constantize.find(id)

    object.mail_received_users.each do |user|
      NotificationMailer.notification_mail(user).deliver_later
      logger.info "#{user.name}にメールを送りました"
    end

    sleep 1                    # wait at least 1 sec
    object.create_notify_mail
  end
end
