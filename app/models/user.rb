class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  has_many :weekly_reports

  def wrote_latest_report?
    return unless group
    latest_reporting_time = group.reporting_time - 1.week
    weekly_reports.maximum('reporting_time') != latest_reporting_time
  end
end
