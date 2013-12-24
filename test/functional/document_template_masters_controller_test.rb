require 'test_helper'

class DocumentTemplateMastersControllerTest < ActionController::TestCase
  setup do
    @document_template_master = document_template_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:document_template_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_template_master" do
    assert_difference('DocumentTemplateMaster.count') do
      post :create, document_template_master: { description: @document_template_master.description, dt_code: @document_template_master.dt_code, file: @document_template_master.file, related_to: @document_template_master.related_to }
    end

    assert_redirected_to document_template_master_path(assigns(:document_template_master))
  end

  test "should show document_template_master" do
    get :show, id: @document_template_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document_template_master
    assert_response :success
  end

  test "should update document_template_master" do
    put :update, id: @document_template_master, document_template_master: { description: @document_template_master.description, dt_code: @document_template_master.dt_code, file: @document_template_master.file, related_to: @document_template_master.related_to }
    assert_redirected_to document_template_master_path(assigns(:document_template_master))
  end

  test "should destroy document_template_master" do
    assert_difference('DocumentTemplateMaster.count', -1) do
      delete :destroy, id: @document_template_master
    end

    assert_redirected_to document_template_masters_path
  end
end
