class AddProcessedContentToWeeklyReports < ActiveRecord::Migration
  def change
    add_column :weekly_reports, :processed_content, :text
  end
end
