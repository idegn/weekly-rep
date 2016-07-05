module NotifyMailSendable
  def create_notify_mail
    NotificationMailWorker.perform_at(performing_at, self.class, id)
  end

  def update_notify_mail
    Sidekiq::ScheduledSet.new.select do |s|
      s.klass == 'NotificationMailWorker' && s.args == [self.class, id]
    end.each(&:delete)

    create_notify_mail
  end

  def mail_received_users
    raise NotImplementedError
  end

  private

  def performing_at
    raise NotImplementedError
  end
end
