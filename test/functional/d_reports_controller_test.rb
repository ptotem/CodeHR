require 'test_helper'

class DReportsControllerTest < ActionController::TestCase
  setup do
    @d_report = d_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_report" do
    assert_difference('DReport.count') do
      post :create, d_report: {  }
    end

    assert_redirected_to d_report_path(assigns(:d_report))
  end

  test "should show d_report" do
    get :show, id: @d_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_report
    assert_response :success
  end

  test "should update d_report" do
    put :update, id: @d_report, d_report: {  }
    assert_redirected_to d_report_path(assigns(:d_report))
  end

  test "should destroy d_report" do
    assert_difference('DReport.count', -1) do
      delete :destroy, id: @d_report
    end

    assert_redirected_to d_reports_path
  end
end
