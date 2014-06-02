require 'test_helper'

class PmsSubgroupsControllerTest < ActionController::TestCase
  setup do
    @pms_subgroup = pms_subgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pms_subgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pms_subgroup" do
    assert_difference('PmsSubgroup.count') do
      post :create, pms_subgroup: { linked_to: @pms_subgroup.linked_to, name: @pms_subgroup.name, percentage: @pms_subgroup.percentage }
    end

    assert_redirected_to pms_subgroup_path(assigns(:pms_subgroup))
  end

  test "should show pms_subgroup" do
    get :show, id: @pms_subgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pms_subgroup
    assert_response :success
  end

  test "should update pms_subgroup" do
    put :update, id: @pms_subgroup, pms_subgroup: { linked_to: @pms_subgroup.linked_to, name: @pms_subgroup.name, percentage: @pms_subgroup.percentage }
    assert_redirected_to pms_subgroup_path(assigns(:pms_subgroup))
  end

  test "should destroy pms_subgroup" do
    assert_difference('PmsSubgroup.count', -1) do
      delete :destroy, id: @pms_subgroup
    end

    assert_redirected_to pms_subgroups_path
  end
end
