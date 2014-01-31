require 'test_helper'

class PlanningManpowersControllerTest < ActionController::TestCase
  setup do
    @planning_manpower = planning_manpowers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planning_manpowers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planning_manpower" do
    assert_difference('PlanningManpower.count') do
      post :create, planning_manpower: { band: @planning_manpower.band, comments: @planning_manpower.comments, ff_source: @planning_manpower.ff_source, group: @planning_manpower.group, location: @planning_manpower.location, position: @planning_manpower.position, position_nature: @planning_manpower.position_nature, supervisor: @planning_manpower.supervisor }
    end

    assert_redirected_to planning_manpower_path(assigns(:planning_manpower))
  end

  test "should show planning_manpower" do
    get :show, id: @planning_manpower
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planning_manpower
    assert_response :success
  end

  test "should update planning_manpower" do
    put :update, id: @planning_manpower, planning_manpower: { band: @planning_manpower.band, comments: @planning_manpower.comments, ff_source: @planning_manpower.ff_source, group: @planning_manpower.group, location: @planning_manpower.location, position: @planning_manpower.position, position_nature: @planning_manpower.position_nature, supervisor: @planning_manpower.supervisor }
    assert_redirected_to planning_manpower_path(assigns(:planning_manpower))
  end

  test "should destroy planning_manpower" do
    assert_difference('PlanningManpower.count', -1) do
      delete :destroy, id: @planning_manpower
    end

    assert_redirected_to planning_manpowers_path
  end
end
