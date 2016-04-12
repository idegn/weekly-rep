class RenameReportingTimeColumnToReportedTime < ActiveRecord::Migration
  def change
    rename_column :weekly_reports, :reporting_time, :reported_time
  end
end
