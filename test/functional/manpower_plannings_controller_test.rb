require 'test_helper'

class ManpowerPlanningsControllerTest < ActionController::TestCase
  setup do
    @manpower_planning = manpower_plannings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manpower_plannings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manpower_planning" do
    assert_difference('ManpowerPlanning.count') do
      post :create, manpower_planning: { final_approved_number: @manpower_planning.final_approved_number, mp_code: @manpower_planning.mp_code, period_from: @manpower_planning.period_from, period_to: @manpower_planning.period_to, requested_by: @manpower_planning.requested_by }
    end

    assert_redirected_to manpower_planning_path(assigns(:manpower_planning))
  end

  test "should show manpower_planning" do
    get :show, id: @manpower_planning
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manpower_planning
    assert_response :success
  end

  test "should update manpower_planning" do
    put :update, id: @manpower_planning, manpower_planning: { final_approved_number: @manpower_planning.final_approved_number, mp_code: @manpower_planning.mp_code, period_from: @manpower_planning.period_from, period_to: @manpower_planning.period_to, requested_by: @manpower_planning.requested_by }
    assert_redirected_to manpower_planning_path(assigns(:manpower_planning))
  end

  test "should destroy manpower_planning" do
    assert_difference('ManpowerPlanning.count', -1) do
      delete :destroy, id: @manpower_planning
    end

    assert_redirected_to manpower_plannings_path
  end
end
