require 'test_helper'

class CommissionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commission" do
    assert_difference('Commission.count') do
      post :create, :commission => { }
    end

    assert_redirected_to commission_path(assigns(:commission))
  end

  test "should show commission" do
    get :show, :id => commissions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => commissions(:one).to_param
    assert_response :success
  end

  test "should update commission" do
    put :update, :id => commissions(:one).to_param, :commission => { }
    assert_redirected_to commission_path(assigns(:commission))
  end

  test "should destroy commission" do
    assert_difference('Commission.count', -1) do
      delete :destroy, :id => commissions(:one).to_param
    end

    assert_redirected_to commissions_path
  end
end
