class Group < ActiveRecord::Base
  has_many :users
  attr_accessor :time, :day_of_week
  after_initialize :set_default, if: :new_record?

  SEC_PER_DAY = 60 * 60 * 24

  def make_reporting_time(hour, min, wday)
    now = Time.now
    sec = SEC_PER_DAY * ((7 + wday - now.wday) % 7)
    self.reporting_time = (Time.local(now.year, now.month, now.day, hour, min) + sec)
  end

  private
  def set_default
    make_reporting_time(18, 0, 0)
  end
end
