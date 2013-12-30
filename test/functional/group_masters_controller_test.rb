require 'test_helper'

class GroupMastersControllerTest < ActionController::TestCase
  setup do
    @group_master = group_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_master" do
    assert_difference('GroupMaster.count') do
      post :create, group_master: {  }
    end

    assert_redirected_to group_master_path(assigns(:group_master))
  end

  test "should show group_master" do
    get :show, id: @group_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_master
    assert_response :success
  end

  test "should update group_master" do
    put :update, id: @group_master, group_master: {  }
    assert_redirected_to group_master_path(assigns(:group_master))
  end

  test "should destroy group_master" do
    assert_difference('GroupMaster.count', -1) do
      delete :destroy, id: @group_master
    end

    assert_redirected_to group_masters_path
  end
end
