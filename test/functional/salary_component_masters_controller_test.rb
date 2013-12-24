require 'test_helper'

class SalaryComponentMastersControllerTest < ActionController::TestCase
  setup do
    @salary_component_master = salary_component_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salary_component_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salary_component_master" do
    assert_difference('SalaryComponentMaster.count') do
      post :create, salary_component_master: { name: @salary_component_master.name }
    end

    assert_redirected_to salary_component_master_path(assigns(:salary_component_master))
  end

  test "should show salary_component_master" do
    get :show, id: @salary_component_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salary_component_master
    assert_response :success
  end

  test "should update salary_component_master" do
    put :update, id: @salary_component_master, salary_component_master: { name: @salary_component_master.name }
    assert_redirected_to salary_component_master_path(assigns(:salary_component_master))
  end

  test "should destroy salary_component_master" do
    assert_difference('SalaryComponentMaster.count', -1) do
      delete :destroy, id: @salary_component_master
    end

    assert_redirected_to salary_component_masters_path
  end
end
