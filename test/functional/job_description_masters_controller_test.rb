require 'test_helper'

class JobDescriptionMastersControllerTest < ActionController::TestCase
  setup do
    @job_description_master = job_description_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_description_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_description_master" do
    assert_difference('JobDescriptionMaster.count') do
      post :create, job_description_master: { description: @job_description_master.description, job_code: @job_description_master.job_code, job_title: @job_description_master.job_title, min_year_of_experience: @job_description_master.min_year_of_experience }
    end

    assert_redirected_to job_description_master_path(assigns(:job_description_master))
  end

  test "should show job_description_master" do
    get :show, id: @job_description_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_description_master
    assert_response :success
  end

  test "should update job_description_master" do
    put :update, id: @job_description_master, job_description_master: { description: @job_description_master.description, job_code: @job_description_master.job_code, job_title: @job_description_master.job_title, min_year_of_experience: @job_description_master.min_year_of_experience }
    assert_redirected_to job_description_master_path(assigns(:job_description_master))
  end

  test "should destroy job_description_master" do
    assert_difference('JobDescriptionMaster.count', -1) do
      delete :destroy, id: @job_description_master
    end

    assert_redirected_to job_description_masters_path
  end
end
