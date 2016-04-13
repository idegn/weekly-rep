class AddPublishedToWeeklyReports < ActiveRecord::Migration
  def change
    add_column :weekly_reports, :published, :boolean, default: false, null: false
  end
end
