require 'test_helper'

class OutletPurchaseOrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlet_purchase_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet_purchase_order" do
    assert_difference('OutletPurchaseOrder.count') do
      post :create, :outlet_purchase_order => { }
    end

    assert_redirected_to outlet_purchase_order_path(assigns(:outlet_purchase_order))
  end

  test "should show outlet_purchase_order" do
    get :show, :id => outlet_purchase_orders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outlet_purchase_orders(:one).to_param
    assert_response :success
  end

  test "should update outlet_purchase_order" do
    put :update, :id => outlet_purchase_orders(:one).to_param, :outlet_purchase_order => { }
    assert_redirected_to outlet_purchase_order_path(assigns(:outlet_purchase_order))
  end

  test "should destroy outlet_purchase_order" do
    assert_difference('OutletPurchaseOrder.count', -1) do
      delete :destroy, :id => outlet_purchase_orders(:one).to_param
    end

    assert_redirected_to outlet_purchase_orders_path
  end
end
