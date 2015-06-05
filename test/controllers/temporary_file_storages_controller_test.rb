require 'test_helper'

class TemporaryFileStoragesControllerTest < ActionController::TestCase
  setup do
    @temporary_file_storage = temporary_file_storages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temporary_file_storages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temporary_file_storage" do
    assert_difference('TemporaryFileStorage.count') do
      post :create, temporary_file_storage: {  }
    end

    assert_redirected_to temporary_file_storage_path(assigns(:temporary_file_storage))
  end

  test "should show temporary_file_storage" do
    get :show, id: @temporary_file_storage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @temporary_file_storage
    assert_response :success
  end

  test "should update temporary_file_storage" do
    patch :update, id: @temporary_file_storage, temporary_file_storage: {  }
    assert_redirected_to temporary_file_storage_path(assigns(:temporary_file_storage))
  end

  test "should destroy temporary_file_storage" do
    assert_difference('TemporaryFileStorage.count', -1) do
      delete :destroy, id: @temporary_file_storage
    end

    assert_redirected_to temporary_file_storages_path
  end
end
