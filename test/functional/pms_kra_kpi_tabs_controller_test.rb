require 'test_helper'

class PmsKraKpiTabsControllerTest < ActionController::TestCase
  setup do
    @pms_kra_kpi_tab = pms_kra_kpi_tabs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pms_kra_kpi_tabs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pms_kra_kpi_tab" do
    assert_difference('PmsKraKpiTab.count') do
      post :create, pms_kra_kpi_tab: { : @pms_kra_kpi_tab., kpi_range1: @pms_kra_kpi_tab.kpi_range1, kpi_range2: @pms_kra_kpi_tab.kpi_range2, kpi_range3: @pms_kra_kpi_tab.kpi_range3, kpi_range4: @pms_kra_kpi_tab.kpi_range4, kpi_range5: @pms_kra_kpi_tab.kpi_range5, kra: @pms_kra_kpi_tab.kra, linked_to: @pms_kra_kpi_tab.linked_to, objorsub: @pms_kra_kpi_tab.objorsub, percentage: @pms_kra_kpi_tab.percentage, unit: @pms_kra_kpi_tab.unit }
    end

    assert_redirected_to pms_kra_kpi_tab_path(assigns(:pms_kra_kpi_tab))
  end

  test "should show pms_kra_kpi_tab" do
    get :show, id: @pms_kra_kpi_tab
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pms_kra_kpi_tab
    assert_response :success
  end

  test "should update pms_kra_kpi_tab" do
    put :update, id: @pms_kra_kpi_tab, pms_kra_kpi_tab: { : @pms_kra_kpi_tab., kpi_range1: @pms_kra_kpi_tab.kpi_range1, kpi_range2: @pms_kra_kpi_tab.kpi_range2, kpi_range3: @pms_kra_kpi_tab.kpi_range3, kpi_range4: @pms_kra_kpi_tab.kpi_range4, kpi_range5: @pms_kra_kpi_tab.kpi_range5, kra: @pms_kra_kpi_tab.kra, linked_to: @pms_kra_kpi_tab.linked_to, objorsub: @pms_kra_kpi_tab.objorsub, percentage: @pms_kra_kpi_tab.percentage, unit: @pms_kra_kpi_tab.unit }
    assert_redirected_to pms_kra_kpi_tab_path(assigns(:pms_kra_kpi_tab))
  end

  test "should destroy pms_kra_kpi_tab" do
    assert_difference('PmsKraKpiTab.count', -1) do
      delete :destroy, id: @pms_kra_kpi_tab
    end

    assert_redirected_to pms_kra_kpi_tabs_path
  end
end
