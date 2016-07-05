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

  def latest_report_time
    ::DateTimeBuilder.new.previous_wday(report_time, report_wday)
  end

  def next_report_time
    ::DateTimeBuilder.new.next_wday(report_time, report_wday)
  end
  alias performing_at next_report_time
end
