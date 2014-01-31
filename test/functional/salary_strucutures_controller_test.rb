require 'test_helper'

class SalaryStrucuturesControllerTest < ActionController::TestCase
  setup do
    @salary_strucuture = salary_strucutures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salary_strucutures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salary_strucuture" do
    assert_difference('SalaryStrucuture.count') do
      post :create, salary_strucuture: { candidate_master_id: @salary_strucuture.candidate_master_id, vacancy_master_id: @salary_strucuture.vacancy_master_id }
    end

    assert_redirected_to salary_strucuture_path(assigns(:salary_strucuture))
  end

  test "should show salary_strucuture" do
    get :show, id: @salary_strucuture
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salary_strucuture
    assert_response :success
  end

  test "should update salary_strucuture" do
    put :update, id: @salary_strucuture, salary_strucuture: { candidate_master_id: @salary_strucuture.candidate_master_id, vacancy_master_id: @salary_strucuture.vacancy_master_id }
    assert_redirected_to salary_strucuture_path(assigns(:salary_strucuture))
  end

  test "should destroy salary_strucuture" do
    assert_difference('SalaryStrucuture.count', -1) do
      delete :destroy, id: @salary_strucuture
    end

    assert_redirected_to salary_strucutures_path
  end
end
