require 'test_helper'

class ContainerListsControllerTest < ActionController::TestCase
  setup do
    @container_list = container_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:container_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create container_list" do
    assert_difference('ContainerList.count') do
      post :create, container_list: {  }
    end

    assert_redirected_to container_list_path(assigns(:container_list))
  end

  test "should show container_list" do
    get :show, id: @container_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @container_list
    assert_response :success
  end

  test "should update container_list" do
    put :update, id: @container_list, container_list: {  }
    assert_redirected_to container_list_path(assigns(:container_list))
  end

  test "should destroy container_list" do
    assert_difference('ContainerList.count', -1) do
      delete :destroy, id: @container_list
    end

    assert_redirected_to container_lists_path
  end
end
