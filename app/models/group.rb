class Group < ActiveRecord::Base
  has_many :users
  has_many :weekly_reports
  attr_accessor :time, :day_of_week
  after_initialize :set_default, if: :new_record?
  after_commit 'NotificationMailWorker.set_next_job', on: [:create, :update]

  def make_reporting_time(hour, min, wday)
    now = Time.now
    days = ((7 + wday - now.wday) % 7).days
    self.reporting_time = (Time.local(now.year, now.month, now.day, hour, min) + days)
    self.reporting_time += 7.days if self.reporting_time < Time.now
  end

  def update_reporting_time
    self.reporting_time += 7.days
    self.save
  end

  private

  def set_default
    make_reporting_time(18, 0, 0)
  end
end
