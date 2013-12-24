require 'test_helper'

class VacancyMastersControllerTest < ActionController::TestCase
  setup do
    @vacancy_master = vacancy_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vacancy_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vacancy_master" do
    assert_difference('VacancyMaster.count') do
      post :create, vacancy_master: { ctc_range_from: @vacancy_master.ctc_range_from, ctc_range_to: @vacancy_master.ctc_range_to, description: @vacancy_master.description, hiring_manager: @vacancy_master.hiring_manager, hr_rep: @vacancy_master.hr_rep, manpower_planning_id: @vacancy_master.manpower_planning_id, sourcing_strategy: @vacancy_master.sourcing_strategy, status: @vacancy_master.status, vacancy_code: @vacancy_master.vacancy_code }
    end

    assert_redirected_to vacancy_master_path(assigns(:vacancy_master))
  end

  test "should show vacancy_master" do
    get :show, id: @vacancy_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vacancy_master
    assert_response :success
  end

  test "should update vacancy_master" do
    put :update, id: @vacancy_master, vacancy_master: { ctc_range_from: @vacancy_master.ctc_range_from, ctc_range_to: @vacancy_master.ctc_range_to, description: @vacancy_master.description, hiring_manager: @vacancy_master.hiring_manager, hr_rep: @vacancy_master.hr_rep, manpower_planning_id: @vacancy_master.manpower_planning_id, sourcing_strategy: @vacancy_master.sourcing_strategy, status: @vacancy_master.status, vacancy_code: @vacancy_master.vacancy_code }
    assert_redirected_to vacancy_master_path(assigns(:vacancy_master))
  end

  test "should destroy vacancy_master" do
    assert_difference('VacancyMaster.count', -1) do
      delete :destroy, id: @vacancy_master
    end

    assert_redirected_to vacancy_masters_path
  end
end
