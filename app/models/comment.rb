class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_report

  after_commit :send_comment_notification

  private

  def send_comment_notification
    # TODO add relation group has comments
    user.group.users.each do |u|
      next if u == user
      NotificationMailer.comment_notification(self, u).deliver_later
    end
  end
end
