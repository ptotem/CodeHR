require 'test_helper'

class ProcessTrsControllerTest < ActionController::TestCase
  setup do
    @process_tr = process_trs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:process_trs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create process_tr" do
    assert_difference('ProcessTr.count') do
      post :create, process_tr: { name: @process_tr.name }
    end

    assert_redirected_to process_tr_path(assigns(:process_tr))
  end

  test "should show process_tr" do
    get :show, id: @process_tr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @process_tr
    assert_response :success
  end

  test "should update process_tr" do
    put :update, id: @process_tr, process_tr: { name: @process_tr.name }
    assert_redirected_to process_tr_path(assigns(:process_tr))
  end

  test "should destroy process_tr" do
    assert_difference('ProcessTr.count', -1) do
      delete :destroy, id: @process_tr
    end

    assert_redirected_to process_trs_path
  end
end
