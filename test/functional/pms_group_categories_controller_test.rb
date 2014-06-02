require 'test_helper'

class PmsGroupCategoriesControllerTest < ActionController::TestCase
  setup do
    @pms_group_category = pms_group_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pms_group_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pms_group_category" do
    assert_difference('PmsGroupCategory.count') do
      post :create, pms_group_category: { name: @pms_group_category.name }
    end

    assert_redirected_to pms_group_category_path(assigns(:pms_group_category))
  end

  test "should show pms_group_category" do
    get :show, id: @pms_group_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pms_group_category
    assert_response :success
  end

  test "should update pms_group_category" do
    put :update, id: @pms_group_category, pms_group_category: { name: @pms_group_category.name }
    assert_redirected_to pms_group_category_path(assigns(:pms_group_category))
  end

  test "should destroy pms_group_category" do
    assert_difference('PmsGroupCategory.count', -1) do
      delete :destroy, id: @pms_group_category
    end

    assert_redirected_to pms_group_categories_path
  end
end
