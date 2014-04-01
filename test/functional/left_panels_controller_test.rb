require 'test_helper'

class LeftPanelsControllerTest < ActionController::TestCase
  setup do
    @left_panel = left_panels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:left_panels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create left_panel" do
    assert_difference('LeftPanel.count') do
      post :create, left_panel: { name: @left_panel.name }
    end

    assert_redirected_to left_panel_path(assigns(:left_panel))
  end

  test "should show left_panel" do
    get :show, id: @left_panel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @left_panel
    assert_response :success
  end

  test "should update left_panel" do
    put :update, id: @left_panel, left_panel: { name: @left_panel.name }
    assert_redirected_to left_panel_path(assigns(:left_panel))
  end

  test "should destroy left_panel" do
    assert_difference('LeftPanel.count', -1) do
      delete :destroy, id: @left_panel
    end

    assert_redirected_to left_panels_path
  end
end
