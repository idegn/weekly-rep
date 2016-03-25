class WeeklyReport < ActiveRecord::Base
  belongs_to :user

  def make_default(current_user)
    self.reporting_time = current_user.group.reporting_time - 1.week
    self.content = current_user.group.template
  end
end
