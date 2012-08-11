require 'test_helper'

class PackingPurchaseRequisitionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:packing_purchase_requisitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create packing_purchase_requisition" do
    assert_difference('PackingPurchaseRequisition.count') do
      post :create, :packing_purchase_requisition => { }
    end

    assert_redirected_to packing_purchase_requisition_path(assigns(:packing_purchase_requisition))
  end

  test "should show packing_purchase_requisition" do
    get :show, :id => packing_purchase_requisitions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => packing_purchase_requisitions(:one).to_param
    assert_response :success
  end

  test "should update packing_purchase_requisition" do
    put :update, :id => packing_purchase_requisitions(:one).to_param, :packing_purchase_requisition => { }
    assert_redirected_to packing_purchase_requisition_path(assigns(:packing_purchase_requisition))
  end

  test "should destroy packing_purchase_requisition" do
    assert_difference('PackingPurchaseRequisition.count', -1) do
      delete :destroy, :id => packing_purchase_requisitions(:one).to_param
    end

    assert_redirected_to packing_purchase_requisitions_path
  end
end
