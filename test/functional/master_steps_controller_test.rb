require 'test_helper'

class MasterStepsControllerTest < ActionController::TestCase
  setup do
    @master_step = master_steps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_steps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_step" do
    assert_difference('MasterStep.count') do
      post :create, master_step: {  }
    end

    assert_redirected_to master_step_path(assigns(:master_step))
  end

  test "should show master_step" do
    get :show, id: @master_step
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_step
    assert_response :success
  end

  test "should update master_step" do
    put :update, id: @master_step, master_step: {  }
    assert_redirected_to master_step_path(assigns(:master_step))
  end

  test "should destroy master_step" do
    assert_difference('MasterStep.count', -1) do
      delete :destroy, id: @master_step
    end

    assert_redirected_to master_steps_path
  end
end
