class WeeklyReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def setup(current_user)
    self.reported_time = current_user.group.reporting_time - 1.week
    self.content = current_user.group.template
  end
end
