require 'test_helper'

class PurchaseOrderHistoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_order_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_order_history" do
    assert_difference('PurchaseOrderHistory.count') do
      post :create, :purchase_order_history => { }
    end

    assert_redirected_to purchase_order_history_path(assigns(:purchase_order_history))
  end

  test "should show purchase_order_history" do
    get :show, :id => purchase_order_histories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => purchase_order_histories(:one).to_param
    assert_response :success
  end

  test "should update purchase_order_history" do
    put :update, :id => purchase_order_histories(:one).to_param, :purchase_order_history => { }
    assert_redirected_to purchase_order_history_path(assigns(:purchase_order_history))
  end

  test "should destroy purchase_order_history" do
    assert_difference('PurchaseOrderHistory.count', -1) do
      delete :destroy, :id => purchase_order_histories(:one).to_param
    end

    assert_redirected_to purchase_order_histories_path
  end
end
