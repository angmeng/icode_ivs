require 'test_helper'

class SalesmenControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salesmen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salesman" do
    assert_difference('Salesman.count') do
      post :create, :salesman => { }
    end

    assert_redirected_to salesman_path(assigns(:salesman))
  end

  test "should show salesman" do
    get :show, :id => salesmen(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => salesmen(:one).to_param
    assert_response :success
  end

  test "should update salesman" do
    put :update, :id => salesmen(:one).to_param, :salesman => { }
    assert_redirected_to salesman_path(assigns(:salesman))
  end

  test "should destroy salesman" do
    assert_difference('Salesman.count', -1) do
      delete :destroy, :id => salesmen(:one).to_param
    end

    assert_redirected_to salesmen_path
  end
end
