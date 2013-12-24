require 'test_helper'

class NotificationMastersControllerTest < ActionController::TestCase
  setup do
    @notification_master = notification_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notification_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notification_master" do
    assert_difference('NotificationMaster.count') do
      post :create, notification_master: { code: @notification_master.code, description: @notification_master.description, title: @notification_master.title, type: @notification_master.type }
    end

    assert_redirected_to notification_master_path(assigns(:notification_master))
  end

  test "should show notification_master" do
    get :show, id: @notification_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notification_master
    assert_response :success
  end

  test "should update notification_master" do
    put :update, id: @notification_master, notification_master: { code: @notification_master.code, description: @notification_master.description, title: @notification_master.title, type: @notification_master.type }
    assert_redirected_to notification_master_path(assigns(:notification_master))
  end

  test "should destroy notification_master" do
    assert_difference('NotificationMaster.count', -1) do
      delete :destroy, id: @notification_master
    end

    assert_redirected_to notification_masters_path
  end
end
