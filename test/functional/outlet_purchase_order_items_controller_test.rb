require 'test_helper'

class OutletPurchaseOrderItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlet_purchase_order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet_purchase_order_item" do
    assert_difference('OutletPurchaseOrderItem.count') do
      post :create, :outlet_purchase_order_item => { }
    end

    assert_redirected_to outlet_purchase_order_item_path(assigns(:outlet_purchase_order_item))
  end

  test "should show outlet_purchase_order_item" do
    get :show, :id => outlet_purchase_order_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outlet_purchase_order_items(:one).to_param
    assert_response :success
  end

  test "should update outlet_purchase_order_item" do
    put :update, :id => outlet_purchase_order_items(:one).to_param, :outlet_purchase_order_item => { }
    assert_redirected_to outlet_purchase_order_item_path(assigns(:outlet_purchase_order_item))
  end

  test "should destroy outlet_purchase_order_item" do
    assert_difference('OutletPurchaseOrderItem.count', -1) do
      delete :destroy, :id => outlet_purchase_order_items(:one).to_param
    end

    assert_redirected_to outlet_purchase_order_items_path
  end
end
