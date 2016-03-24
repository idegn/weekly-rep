class WeeklyReport < ActiveRecord::Base
  belongs_to :user

  def make_default(current_user)
    make_reporting_time(current_user.group.reporting_time)
    self.content = current_user.group.template
  end

  private
  def make_reporting_time(reporting_time)
    self.reporting_time = reporting_time
    if Time.now.wday != self.reporting_time.wday
      self.reporting_time -= 60 * 60 * 24 * 7
    end
  end
end
