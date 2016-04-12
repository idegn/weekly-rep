require 'test_helper'

class WeeklyReportsControllerTest < ActionController::TestCase
  setup do
    @weekly_report = weekly_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekly_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekly_report" do
    assert_difference('WeeklyReport.count') do
      post :create, weekly_report: { content: @weekly_report.content, reported_time: @weekly_report.reported_time, user_id: @weekly_report.user_id }
    end

    assert_redirected_to weekly_report_path(assigns(:weekly_report))
  end

  test "should show weekly_report" do
    get :show, id: @weekly_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weekly_report
    assert_response :success
  end

  test "should update weekly_report" do
    patch :update, id: @weekly_report, weekly_report: { content: @weekly_report.content, reported_time: @weekly_report.reported_time, user_id: @weekly_report.user_id }
    assert_redirected_to weekly_report_path(assigns(:weekly_report))
  end

  test "should destroy weekly_report" do
    assert_difference('WeeklyReport.count', -1) do
      delete :destroy, id: @weekly_report
    end

    assert_redirected_to weekly_reports_path
  end
end
