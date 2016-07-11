class WeeklyReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments
  scope :ordered_reports, -> { where(published: true).order('reported_time DESC') }

  after_commit :send_write_notification

  def setup(current_user)
    if current_user.reported_this_week?
      self.reported_time = current_user.group.next_report_time
    else
      self.reported_time = current_user.group.latest_report_time
    end
    self.content = current_user.group.template
  end

  private

  def send_write_notification
    group.users.each do |u|
      next if u == user
      NotificationMailer.write_notification(user, u).deliver_later
    end
  end
end
