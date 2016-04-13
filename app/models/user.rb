class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  has_many :weekly_reports

  def latest_report_published?
    return unless group
    latest_reported_time = group.reporting_time - 1.week
    weekly_reports.find_by(reported_time: latest_reported_time, published: true)
  end

  def next_draft
    return unless group
    next_reporting_time = group.reporting_time
    weekly_reports.find_by(reported_time: next_reporting_time, published: false)
  end

  def latest_draft
    return unless group
    latest_reported_time = group.reporting_time - 1.week
    weekly_reports.find_by(reported_time: latest_reported_time, published: false)
  end
end
