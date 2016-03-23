class AddReportingTimeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :reporting_time, :datetime
  end
end
