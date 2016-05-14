class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_report
end
