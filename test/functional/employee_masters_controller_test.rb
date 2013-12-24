require 'test_helper'

class EmployeeMastersControllerTest < ActionController::TestCase
  setup do
    @employee_master = employee_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee_master" do
    assert_difference('EmployeeMaster.count') do
      post :create, employee_master: { account_number: @employee_master.account_number, address_for_communication: @employee_master.address_for_communication, band_id: @employee_master.band_id, bank_name: @employee_master.bank_name, blood_group: @employee_master.blood_group, contact_numbers: @employee_master.contact_numbers, current_designation: @employee_master.current_designation, date_of_birth: @employee_master.date_of_birth, date_of_joining: @employee_master.date_of_joining, date_of_leaving: @employee_master.date_of_leaving, designation_joined_at: @employee_master.designation_joined_at, employee_code: @employee_master.employee_code, employee_middle_name_name: @employee_master.employee_middle_name_name, employee_name: @employee_master.employee_name, esic_no: @employee_master.esic_no, gender: @employee_master.gender, group_id: @employee_master.group_id, job_id: @employee_master.job_id, marital_status: @employee_master.marital_status, nature_of_separation: @employee_master.nature_of_separation, official_email: @employee_master.official_email, pan_no: @employee_master.pan_no, personal_address: @employee_master.personal_address, personal_email: @employee_master.personal_email, remarks_1: @employee_master.remarks_1, remarks_2: @employee_master.remarks_2, remarks_3: @employee_master.remarks_3, remarks_4: @employee_master.remarks_4, remarks_5: @employee_master.remarks_5, rf_no: @employee_master.rf_no, status: @employee_master.status, total_work_exp_months: @employee_master.total_work_exp_months, total_work_exp_years: @employee_master.total_work_exp_years, user_id: @employee_master.user_id }
    end

    assert_redirected_to employee_master_path(assigns(:employee_master))
  end

  test "should show employee_master" do
    get :show, id: @employee_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee_master
    assert_response :success
  end

  test "should update employee_master" do
    put :update, id: @employee_master, employee_master: { account_number: @employee_master.account_number, address_for_communication: @employee_master.address_for_communication, band_id: @employee_master.band_id, bank_name: @employee_master.bank_name, blood_group: @employee_master.blood_group, contact_numbers: @employee_master.contact_numbers, current_designation: @employee_master.current_designation, date_of_birth: @employee_master.date_of_birth, date_of_joining: @employee_master.date_of_joining, date_of_leaving: @employee_master.date_of_leaving, designation_joined_at: @employee_master.designation_joined_at, employee_code: @employee_master.employee_code, employee_middle_name_name: @employee_master.employee_middle_name_name, employee_name: @employee_master.employee_name, esic_no: @employee_master.esic_no, gender: @employee_master.gender, group_id: @employee_master.group_id, job_id: @employee_master.job_id, marital_status: @employee_master.marital_status, nature_of_separation: @employee_master.nature_of_separation, official_email: @employee_master.official_email, pan_no: @employee_master.pan_no, personal_address: @employee_master.personal_address, personal_email: @employee_master.personal_email, remarks_1: @employee_master.remarks_1, remarks_2: @employee_master.remarks_2, remarks_3: @employee_master.remarks_3, remarks_4: @employee_master.remarks_4, remarks_5: @employee_master.remarks_5, rf_no: @employee_master.rf_no, status: @employee_master.status, total_work_exp_months: @employee_master.total_work_exp_months, total_work_exp_years: @employee_master.total_work_exp_years, user_id: @employee_master.user_id }
    assert_redirected_to employee_master_path(assigns(:employee_master))
  end

  test "should destroy employee_master" do
    assert_difference('EmployeeMaster.count', -1) do
      delete :destroy, id: @employee_master
    end

    assert_redirected_to employee_masters_path
  end
end
