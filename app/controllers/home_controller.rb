class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.group
      @reports = current_user.group.weekly_reports.includes(:user)
      recent_time = @reports.maximum(:reporting_time)
      @reports = @reports.where('reporting_time = ?', recent_time).order('updated_at DESC')
    end
  end
end
