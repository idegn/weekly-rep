class WeeklyReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments
  scope :ordered_reports, -> { where(published: true).order('reported_time DESC') }

  after_create :send_write_notification
  before_save :save_processed_content

  def setup(current_user)
    if current_user.reported_this_week?
      self.reported_time = current_user.group.next_report_time
    else
      self.reported_time = current_user.group.latest_report_time
    end

    self.content = current_user.latest_report ?
                     current_user.latest_report.content :
                     current_user.group.template
  end

  def previous
    user.weekly_reports.where('reported_time < ?', reported_time).order('reported_time desc').first
  end

  def next
    user.weekly_reports.where('reported_time > ?', reported_time).order('reported_time asc').first
  end

  private

  def send_write_notification
    group.users.each do |u|
      next if u == user
      NotificationMailer.write_notification(user, u).deliver_later
    end
  end

  def save_processed_content
    processed_content = Qiita::Markdown::Processor.new.call(content)[:output].to_s
    self.processed_content = processed_content
  end
end
