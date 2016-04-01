class AddGroupRefToWeeklyReports < ActiveRecord::Migration
  def change
    add_reference :weekly_reports, :group, index: true, foreign_key: true
  end
end
