class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  has_many :weekly_reports
  has_many :comments

  def approved_user?
    joined_group? && approved?
  end

  def joined_group?
    !!group_id
  end

  def owned_report?(report)
    self == report.user
  end

  def reported_this_week?
    weekly_reports.find_by(reported_time: group.latest_report_time, published: true)
  end

  def latest_report
    weekly_reports.order(reported_time: :desc).first
  end

  def next_draft
    weekly_reports.find_by(reported_time: group.next_report_time, published: false)
  end

  def latest_draft
    weekly_reports.find_by(reported_time: group.latest_report_time, published: false)
  end
end
