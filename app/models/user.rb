class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  has_many :weekly_reports

  def wrote_latest_report?
    return unless group
    latest_reported_time = group.reporting_time - 1.week
    weekly_reports.maximum('reported_time') != latest_reported_time
  end
end
