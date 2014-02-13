require 'test_helper'

class MasterProsControllerTest < ActionController::TestCase
  setup do
    @master_pro = master_pros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_pros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_pro" do
    assert_difference('MasterPro.count') do
      post :create, master_pro: {  }
    end

    assert_redirected_to master_pro_path(assigns(:master_pro))
  end

  test "should show master_pro" do
    get :show, id: @master_pro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_pro
    assert_response :success
  end

  test "should update master_pro" do
    put :update, id: @master_pro, master_pro: {  }
    assert_redirected_to master_pro_path(assigns(:master_pro))
  end

  test "should destroy master_pro" do
    assert_difference('MasterPro.count', -1) do
      delete :destroy, id: @master_pro
    end

    assert_redirected_to master_pros_path
  end
end
