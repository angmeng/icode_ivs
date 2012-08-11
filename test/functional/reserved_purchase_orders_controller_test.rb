require 'test_helper'

class ReservedPurchaseOrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reserved_purchase_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reserved_purchase_order" do
    assert_difference('ReservedPurchaseOrder.count') do
      post :create, :reserved_purchase_order => { }
    end

    assert_redirected_to reserved_purchase_order_path(assigns(:reserved_purchase_order))
  end

  test "should show reserved_purchase_order" do
    get :show, :id => reserved_purchase_orders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reserved_purchase_orders(:one).to_param
    assert_response :success
  end

  test "should update reserved_purchase_order" do
    put :update, :id => reserved_purchase_orders(:one).to_param, :reserved_purchase_order => { }
    assert_redirected_to reserved_purchase_order_path(assigns(:reserved_purchase_order))
  end

  test "should destroy reserved_purchase_order" do
    assert_difference('ReservedPurchaseOrder.count', -1) do
      delete :destroy, :id => reserved_purchase_orders(:one).to_param
    end

    assert_redirected_to reserved_purchase_orders_path
  end
end
