class CreateWeeklyReports < ActiveRecord::Migration
  def change
    create_table :weekly_reports do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content
      t.datetime :reporting_time

      t.timestamps null: false
    end
  end
end
