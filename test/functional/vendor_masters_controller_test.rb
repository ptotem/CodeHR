require 'test_helper'

class VendorMastersControllerTest < ActionController::TestCase
  setup do
    @vendor_master = vendor_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_master" do
    assert_difference('VendorMaster.count') do
      post :create, vendor_master: { office_fax_number1: @vendor_master.office_fax_number1, office_fax_number2: @vendor_master.office_fax_number2, office_phone_number: @vendor_master.office_phone_number, vendor_code: @vendor_master.vendor_code, vendor_name: @vendor_master.vendor_name, vendor_type: @vendor_master.vendor_type }
    end

    assert_redirected_to vendor_master_path(assigns(:vendor_master))
  end

  test "should show vendor_master" do
    get :show, id: @vendor_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_master
    assert_response :success
  end

  test "should update vendor_master" do
    put :update, id: @vendor_master, vendor_master: { office_fax_number1: @vendor_master.office_fax_number1, office_fax_number2: @vendor_master.office_fax_number2, office_phone_number: @vendor_master.office_phone_number, vendor_code: @vendor_master.vendor_code, vendor_name: @vendor_master.vendor_name, vendor_type: @vendor_master.vendor_type }
    assert_redirected_to vendor_master_path(assigns(:vendor_master))
  end

  test "should destroy vendor_master" do
    assert_difference('VendorMaster.count', -1) do
      delete :destroy, id: @vendor_master
    end

    assert_redirected_to vendor_masters_path
  end
end
