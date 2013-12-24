require 'test_helper'

class RatingScalesControllerTest < ActionController::TestCase
  setup do
    @rating_scale = rating_scales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rating_scales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rating_scale" do
    assert_difference('RatingScale.count') do
      post :create, rating_scale: { description: @rating_scale.description, name: @rating_scale.name }
    end

    assert_redirected_to rating_scale_path(assigns(:rating_scale))
  end

  test "should show rating_scale" do
    get :show, id: @rating_scale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rating_scale
    assert_response :success
  end

  test "should update rating_scale" do
    put :update, id: @rating_scale, rating_scale: { description: @rating_scale.description, name: @rating_scale.name }
    assert_redirected_to rating_scale_path(assigns(:rating_scale))
  end

  test "should destroy rating_scale" do
    assert_difference('RatingScale.count', -1) do
      delete :destroy, id: @rating_scale
    end

    assert_redirected_to rating_scales_path
  end
end
