require 'test_helper'

class DocumentMastersControllerTest < ActionController::TestCase
  setup do
    @document_master = document_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:document_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_master" do
    assert_difference('DocumentMaster.count') do
      post :create, document_master: { doc_code: @document_master.doc_code, name: @document_master.name, owner: @document_master.owner, vc_needed: @document_master.vc_needed }
    end

    assert_redirected_to document_master_path(assigns(:document_master))
  end

  test "should show document_master" do
    get :show, id: @document_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document_master
    assert_response :success
  end

  test "should update document_master" do
    put :update, id: @document_master, document_master: { doc_code: @document_master.doc_code, name: @document_master.name, owner: @document_master.owner, vc_needed: @document_master.vc_needed }
    assert_redirected_to document_master_path(assigns(:document_master))
  end

  test "should destroy document_master" do
    assert_difference('DocumentMaster.count', -1) do
      delete :destroy, id: @document_master
    end

    assert_redirected_to document_masters_path
  end
end
