require 'test_helper'

class AbilityMatricesControllerTest < ActionController::TestCase
  setup do
    @ability_matrix = ability_matrices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ability_matrices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ability_matrix" do
    assert_difference('AbilityMatrix.count') do
      post :create, ability_matrix: {  }
    end

    assert_redirected_to ability_matrix_path(assigns(:ability_matrix))
  end

  test "should show ability_matrix" do
    get :show, id: @ability_matrix
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ability_matrix
    assert_response :success
  end

  test "should update ability_matrix" do
    put :update, id: @ability_matrix, ability_matrix: {  }
    assert_redirected_to ability_matrix_path(assigns(:ability_matrix))
  end

  test "should destroy ability_matrix" do
    assert_difference('AbilityMatrix.count', -1) do
      delete :destroy, id: @ability_matrix
    end

    assert_redirected_to ability_matrices_path
  end
end
