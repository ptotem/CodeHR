require 'test_helper'

class RatingMeasuresControllerTest < ActionController::TestCase
  setup do
    @rating_measure = rating_measures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rating_measures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rating_measure" do
    assert_difference('RatingMeasure.count') do
      post :create, rating_measure: { name: @rating_measure.name, priority: @rating_measure.priority, range_from: @rating_measure.range_from, range_to: @rating_measure.range_to, score: @rating_measure.score }
    end

    assert_redirected_to rating_measure_path(assigns(:rating_measure))
  end

  test "should show rating_measure" do
    get :show, id: @rating_measure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rating_measure
    assert_response :success
  end

  test "should update rating_measure" do
    put :update, id: @rating_measure, rating_measure: { name: @rating_measure.name, priority: @rating_measure.priority, range_from: @rating_measure.range_from, range_to: @rating_measure.range_to, score: @rating_measure.score }
    assert_redirected_to rating_measure_path(assigns(:rating_measure))
  end

  test "should destroy rating_measure" do
    assert_difference('RatingMeasure.count', -1) do
      delete :destroy, id: @rating_measure
    end

    assert_redirected_to rating_measures_path
  end
end
