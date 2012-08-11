require 'test_helper'

class OutletStaffsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlet_staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet_staff" do
    assert_difference('OutletStaff.count') do
      post :create, :outlet_staff => { }
    end

    assert_redirected_to outlet_staff_path(assigns(:outlet_staff))
  end

  test "should show outlet_staff" do
    get :show, :id => outlet_staffs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outlet_staffs(:one).to_param
    assert_response :success
  end

  test "should update outlet_staff" do
    put :update, :id => outlet_staffs(:one).to_param, :outlet_staff => { }
    assert_redirected_to outlet_staff_path(assigns(:outlet_staff))
  end

  test "should destroy outlet_staff" do
    assert_difference('OutletStaff.count', -1) do
      delete :destroy, :id => outlet_staffs(:one).to_param
    end

    assert_redirected_to outlet_staffs_path
  end
end
