class AddIndexToWeeklyReports < ActiveRecord::Migration
  def change
    add_index :weekly_reports, :created_at
  end
end
