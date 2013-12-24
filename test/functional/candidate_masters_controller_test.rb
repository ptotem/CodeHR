require 'test_helper'

class CandidateMastersControllerTest < ActionController::TestCase
  setup do
    @candidate_master = candidate_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:candidate_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create candidate_master" do
    assert_difference('CandidateMaster.count') do
      post :create, candidate_master: { account_number: @candidate_master.account_number, bank_name: @candidate_master.bank_name, candidate_code: @candidate_master.candidate_code, candidate_middle_name: @candidate_master.candidate_middle_name, candidate_name: @candidate_master.candidate_name, current_location: @candidate_master.current_location, date_of_birth: @candidate_master.date_of_birth, esic_no: @candidate_master.esic_no, gender: @candidate_master.gender, marital_status: @candidate_master.marital_status, notice_period: @candidate_master.notice_period, notice_period_buyback?: @candidate_master.notice_period_buyback?, notice_period_buyback_amount: @candidate_master.notice_period_buyback_amount, official_email: @candidate_master.official_email, pan_no: @candidate_master.pan_no, personal_email: @candidate_master.personal_email, pf_no: @candidate_master.pf_no, remarks_1: @candidate_master.remarks_1, remarks_2: @candidate_master.remarks_2, remarks_3: @candidate_master.remarks_3, remarks_4: @candidate_master.remarks_4, remarks_5: @candidate_master.remarks_5, salary_expectation_fixed: @candidate_master.salary_expectation_fixed, salary_expectation_variable: @candidate_master.salary_expectation_variable, status: @candidate_master.status, total_work_exp_months: @candidate_master.total_work_exp_months, total_work_exp_years: @candidate_master.total_work_exp_years }
    end

    assert_redirected_to candidate_master_path(assigns(:candidate_master))
  end

  test "should show candidate_master" do
    get :show, id: @candidate_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @candidate_master
    assert_response :success
  end

  test "should update candidate_master" do
    put :update, id: @candidate_master, candidate_master: { account_number: @candidate_master.account_number, bank_name: @candidate_master.bank_name, candidate_code: @candidate_master.candidate_code, candidate_middle_name: @candidate_master.candidate_middle_name, candidate_name: @candidate_master.candidate_name, current_location: @candidate_master.current_location, date_of_birth: @candidate_master.date_of_birth, esic_no: @candidate_master.esic_no, gender: @candidate_master.gender, marital_status: @candidate_master.marital_status, notice_period: @candidate_master.notice_period, notice_period_buyback?: @candidate_master.notice_period_buyback?, notice_period_buyback_amount: @candidate_master.notice_period_buyback_amount, official_email: @candidate_master.official_email, pan_no: @candidate_master.pan_no, personal_email: @candidate_master.personal_email, pf_no: @candidate_master.pf_no, remarks_1: @candidate_master.remarks_1, remarks_2: @candidate_master.remarks_2, remarks_3: @candidate_master.remarks_3, remarks_4: @candidate_master.remarks_4, remarks_5: @candidate_master.remarks_5, salary_expectation_fixed: @candidate_master.salary_expectation_fixed, salary_expectation_variable: @candidate_master.salary_expectation_variable, status: @candidate_master.status, total_work_exp_months: @candidate_master.total_work_exp_months, total_work_exp_years: @candidate_master.total_work_exp_years }
    assert_redirected_to candidate_master_path(assigns(:candidate_master))
  end

  test "should destroy candidate_master" do
    assert_difference('CandidateMaster.count', -1) do
      delete :destroy, id: @candidate_master
    end

    assert_redirected_to candidate_masters_path
  end
end
