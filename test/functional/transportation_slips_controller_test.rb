require 'test_helper'

class TransportationSlipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transportation_slips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transportation_slip" do
    assert_difference('TransportationSlip.count') do
      post :create, :transportation_slip => { }
    end

    assert_redirected_to transportation_slip_path(assigns(:transportation_slip))
  end

  test "should show transportation_slip" do
    get :show, :id => transportation_slips(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => transportation_slips(:one).to_param
    assert_response :success
  end

  test "should update transportation_slip" do
    put :update, :id => transportation_slips(:one).to_param, :transportation_slip => { }
    assert_redirected_to transportation_slip_path(assigns(:transportation_slip))
  end

  test "should destroy transportation_slip" do
    assert_difference('TransportationSlip.count', -1) do
      delete :destroy, :id => transportation_slips(:one).to_param
    end

    assert_redirected_to transportation_slips_path
  end
end
