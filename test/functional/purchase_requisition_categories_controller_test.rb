require 'test_helper'

class PurchaseRequisitionCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_requisition_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_requisition_category" do
    assert_difference('PurchaseRequisitionCategory.count') do
      post :create, :purchase_requisition_category => { }
    end

    assert_redirected_to purchase_requisition_category_path(assigns(:purchase_requisition_category))
  end

  test "should show purchase_requisition_category" do
    get :show, :id => purchase_requisition_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => purchase_requisition_categories(:one).to_param
    assert_response :success
  end

  test "should update purchase_requisition_category" do
    put :update, :id => purchase_requisition_categories(:one).to_param, :purchase_requisition_category => { }
    assert_redirected_to purchase_requisition_category_path(assigns(:purchase_requisition_category))
  end

  test "should destroy purchase_requisition_category" do
    assert_difference('PurchaseRequisitionCategory.count', -1) do
      delete :destroy, :id => purchase_requisition_categories(:one).to_param
    end

    assert_redirected_to purchase_requisition_categories_path
  end
end
