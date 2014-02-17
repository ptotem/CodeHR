require 'test_helper'

class ProcessTransactsControllerTest < ActionController::TestCase
  setup do
    @process_transact = process_transacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:process_transacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create process_transact" do
    assert_difference('ProcessTransact.count') do
      post :create, process_transact: {  }
    end

    assert_redirected_to process_transact_path(assigns(:process_transact))
  end

  test "should show process_transact" do
    get :show, id: @process_transact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @process_transact
    assert_response :success
  end

  test "should update process_transact" do
    put :update, id: @process_transact, process_transact: {  }
    assert_redirected_to process_transact_path(assigns(:process_transact))
  end

  test "should destroy process_transact" do
    assert_difference('ProcessTransact.count', -1) do
      delete :destroy, id: @process_transact
    end

    assert_redirected_to process_transacts_path
  end
end
