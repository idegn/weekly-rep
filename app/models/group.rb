class Group < ActiveRecord::Base
  has_many :users
  has_many :weekly_reports
  attr_accessor :time, :day_of_week
  after_initialize :set_default, if: :new_record?
  after_commit 'NotificationMailWorker.set_next_job', on: [:create, :update]

  def set_reporting_time(hour, min, wday)
    now = Time.now
    prev_sunday = (now - now.wday.days).beginning_of_day
    the_day_of_this_week = prev_sunday.days_since(wday)
    reporting_time_of_this_week = the_day_of_this_week + hour.hours + min.minutes
    if reporting_time_of_this_week < Time.now
      self.reporting_time = reporting_time_of_this_week + 1.week
    else
      self.reporting_time = reporting_time_of_this_week
    end
  end

  def update_reporting_time
    self.reporting_time += 7.days
    self.save
  end

  private

  def set_default
    set_reporting_time(18, 0, 0)
  end
end
