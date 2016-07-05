class Group < ActiveRecord::Base
  has_many :users
  has_many :weekly_reports

  include NotifyMailSendable

  after_create :create_notify_mail
  after_update :update_notify_mail

  def belonging_users
    users.where(approved: true)
  end
  alias mail_received_users belonging_users

  def request_users
    users.where(approved: false)
  end

  def latest_reported_time
    ::DateTimeBuilder.new.last_week(report_time, report_wday)
  end

  private

  def performing_at
    ::DateTimeBuilder.new.next_week(report_time, report_wday)
  end
end
