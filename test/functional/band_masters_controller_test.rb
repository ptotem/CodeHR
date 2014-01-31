require 'test_helper'

class BandMastersControllerTest < ActionController::TestCase
  setup do
    @band_master = band_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:band_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create band_master" do
    assert_difference('BandMaster.count') do
      post :create, band_master: {  }
    end

    assert_redirected_to band_master_path(assigns(:band_master))
  end

  test "should show band_master" do
    get :show, id: @band_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @band_master
    assert_response :success
  end

  test "should update band_master" do
    put :update, id: @band_master, band_master: {  }
    assert_redirected_to band_master_path(assigns(:band_master))
  end

  test "should destroy band_master" do
    assert_difference('BandMaster.count', -1) do
      delete :destroy, id: @band_master
    end

    assert_redirected_to band_masters_path
  end
end
