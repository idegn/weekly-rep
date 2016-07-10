class WeeklyReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments
  scope :ordered_reports, -> { where(published: true).order('reported_time DESC') }

  def setup(current_user)
    if current_user.reported_this_week?
      self.reported_time = current_user.group.next_report_time
    else
      self.reported_time = current_user.group.latest_report_time
    end
    self.content = current_user.group.template
  end
end
