require 'test_helper'

class VacancySchedulingsControllerTest < ActionController::TestCase
  setup do
    @vacancy_scheduling = vacancy_schedulings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vacancy_schedulings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vacancy_scheduling" do
    assert_difference('VacancyScheduling.count') do
      post :create, vacancy_scheduling: {  }
    end

    assert_redirected_to vacancy_scheduling_path(assigns(:vacancy_scheduling))
  end

  test "should show vacancy_scheduling" do
    get :show, id: @vacancy_scheduling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vacancy_scheduling
    assert_response :success
  end

  test "should update vacancy_scheduling" do
    put :update, id: @vacancy_scheduling, vacancy_scheduling: {  }
    assert_redirected_to vacancy_scheduling_path(assigns(:vacancy_scheduling))
  end

  test "should destroy vacancy_scheduling" do
    assert_difference('VacancyScheduling.count', -1) do
      delete :destroy, id: @vacancy_scheduling
    end

    assert_redirected_to vacancy_schedulings_path
  end
end
