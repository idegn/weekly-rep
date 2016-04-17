class Group < ActiveRecord::Base
  has_many :users
  has_many :weekly_reports
  attr_accessor :time, :day_of_week
  after_initialize :set_default, if: :new_record?
  after_commit 'NotificationMailWorker.set_next_job', on: [:create, :update]

  def set_reporting_time(hour, min, wday)
    self.reporting_time = calculate_reporting_time(hour, min, wday)
  end

  def update_reporting_time
    self.reporting_time += 7.days
    self.save
  end

  def belonging_users
    self.users.where(approved: true)
  end

  private

  def set_default
    set_reporting_time(18, 0, 0)
  end

  def calculate_reporting_time(hour, min, wday)
    today = Time.now.beginning_of_day
    prev_sunday = today - today.wday.days
    day_of_this_week = prev_sunday.days_since(wday)
    reporting_time_of_this_week = day_of_this_week + hour.hours + min.minutes
    if reporting_time_of_this_week < Time.now
      return reporting_time_of_this_week + 1.week
    else
      return reporting_time_of_this_week
    end
  end
end
