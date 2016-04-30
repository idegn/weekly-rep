class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.group && current_user.approved
      @reports = current_user.group.weekly_reports.where(published: true).includes(:user)
      @reports = @reports.where('reported_time > ?', 1.week.ago).order('updated_at DESC')
    end
  end
end
