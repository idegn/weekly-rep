require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { content: @comment.content, user_id: @comment.user_id, weekly_report_id: @comment.weekly_report_id }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end
end
