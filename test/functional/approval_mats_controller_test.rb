require 'test_helper'

class ApprovalMatsControllerTest < ActionController::TestCase
  setup do
    @approval_mat = approval_mats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:approval_mats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create approval_mat" do
    assert_difference('ApprovalMat.count') do
      post :create, approval_mat: {  }
    end

    assert_redirected_to approval_mat_path(assigns(:approval_mat))
  end

  test "should show approval_mat" do
    get :show, id: @approval_mat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @approval_mat
    assert_response :success
  end

  test "should update approval_mat" do
    put :update, id: @approval_mat, approval_mat: {  }
    assert_redirected_to approval_mat_path(assigns(:approval_mat))
  end

  test "should destroy approval_mat" do
    assert_difference('ApprovalMat.count', -1) do
      delete :destroy, id: @approval_mat
    end

    assert_redirected_to approval_mats_path
  end
end
