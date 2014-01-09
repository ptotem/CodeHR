require 'test_helper'

class RatingConfsControllerTest < ActionController::TestCase
  setup do
    @rating_conf = rating_confs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rating_confs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rating_conf" do
    assert_difference('RatingConf.count') do
      post :create, rating_conf: { col_lable: @rating_conf.col_lable, col_name: @rating_conf.col_name, col_seqience: @rating_conf.col_seqience, col_type: @rating_conf.col_type, col_validation: @rating_conf.col_validation }
    end

    assert_redirected_to rating_conf_path(assigns(:rating_conf))
  end

  test "should show rating_conf" do
    get :show, id: @rating_conf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rating_conf
    assert_response :success
  end

  test "should update rating_conf" do
    put :update, id: @rating_conf, rating_conf: { col_lable: @rating_conf.col_lable, col_name: @rating_conf.col_name, col_seqience: @rating_conf.col_seqience, col_type: @rating_conf.col_type, col_validation: @rating_conf.col_validation }
    assert_redirected_to rating_conf_path(assigns(:rating_conf))
  end

  test "should destroy rating_conf" do
    assert_difference('RatingConf.count', -1) do
      delete :destroy, id: @rating_conf
    end

    assert_redirected_to rating_confs_path
  end
end
