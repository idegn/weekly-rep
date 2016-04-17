class NotificationMailWorker
  include Sidekiq::Worker

  def perform(reporting_time)
    groups = Group.where(reporting_time: reporting_time)
    groups.each do |group|
      group.belonging_users.each do |user|
        NotificationMailer.notification_mail(user).deliver_later
        logger.info user.name + "にメールを送りました"
      end

      group.update_reporting_time
    end

    NotificationMailWorker.set_next_job
  end

  class << self
    def set_next_job
      delete_jobs
      create_next_job
    end

    def delete_jobs
      Sidekiq::ScheduledSet.new.select do |s|
        s.item['class'] == 'NotificationMailWorker'
      end.map(&:delete)
    end

    def create_next_job
      next_reporting_time = Group.minimum(:reporting_time)
      perform_at(next_reporting_time, next_reporting_time)
    end
  end
end
