require 'test_helper'

class CompensationComponentsControllerTest < ActionController::TestCase
  setup do
    @compensation_component = compensation_components(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compensation_components)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create compensation_component" do
    assert_difference('CompensationComponent.count') do
      post :create, compensation_component: { final_ctc_fixed: @compensation_component.final_ctc_fixed, final_ctc_varriable: @compensation_component.final_ctc_varriable }
    end

    assert_redirected_to compensation_component_path(assigns(:compensation_component))
  end

  test "should show compensation_component" do
    get :show, id: @compensation_component
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @compensation_component
    assert_response :success
  end

  test "should update compensation_component" do
    put :update, id: @compensation_component, compensation_component: { final_ctc_fixed: @compensation_component.final_ctc_fixed, final_ctc_varriable: @compensation_component.final_ctc_varriable }
    assert_redirected_to compensation_component_path(assigns(:compensation_component))
  end

  test "should destroy compensation_component" do
    assert_difference('CompensationComponent.count', -1) do
      delete :destroy, id: @compensation_component
    end

    assert_redirected_to compensation_components_path
  end
end
