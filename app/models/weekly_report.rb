class WeeklyReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments
  scope :ordered_reports, -> { where(published: true).order('reported_time DESC') }

  def setup(current_user)
    if current_user.latest_report_published?
      self.reported_time = current_user.group.reporting_time
    else
      self.reported_time = current_user.group.reporting_time - 1.week
    end
    self.content = current_user.group.template
  end
end
