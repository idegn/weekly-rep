class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.group && current_user.approved
      @reports = current_user.group.weekly_reports.where(published: true).includes(:user)
      recent_time = @reports.maximum(:reported_time)
      @reports = @reports.where('reported_time = ?', recent_time).order('updated_at DESC')
    end
  end
end
