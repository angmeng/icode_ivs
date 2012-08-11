require 'test_helper'

class OutletDeliveryOrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlet_delivery_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet_delivery_order" do
    assert_difference('OutletDeliveryOrder.count') do
      post :create, :outlet_delivery_order => { }
    end

    assert_redirected_to outlet_delivery_order_path(assigns(:outlet_delivery_order))
  end

  test "should show outlet_delivery_order" do
    get :show, :id => outlet_delivery_orders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outlet_delivery_orders(:one).to_param
    assert_response :success
  end

  test "should update outlet_delivery_order" do
    put :update, :id => outlet_delivery_orders(:one).to_param, :outlet_delivery_order => { }
    assert_redirected_to outlet_delivery_order_path(assigns(:outlet_delivery_order))
  end

  test "should destroy outlet_delivery_order" do
    assert_difference('OutletDeliveryOrder.count', -1) do
      delete :destroy, :id => outlet_delivery_orders(:one).to_param
    end

    assert_redirected_to outlet_delivery_orders_path
  end
end
