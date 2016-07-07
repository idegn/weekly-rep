class AddTimeWdayToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :report_time, :time
    add_column :groups, :report_wday, :integer
  end
end
