require 'test_helper'

class CustomerPricingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_pricings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_pricing" do
    assert_difference('CustomerPricing.count') do
      post :create, :customer_pricing => { }
    end

    assert_redirected_to customer_pricing_path(assigns(:customer_pricing))
  end

  test "should show customer_pricing" do
    get :show, :id => customer_pricings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => customer_pricings(:one).to_param
    assert_response :success
  end

  test "should update customer_pricing" do
    put :update, :id => customer_pricings(:one).to_param, :customer_pricing => { }
    assert_redirected_to customer_pricing_path(assigns(:customer_pricing))
  end

  test "should destroy customer_pricing" do
    assert_difference('CustomerPricing.count', -1) do
      delete :destroy, :id => customer_pricings(:one).to_param
    end

    assert_redirected_to customer_pricings_path
  end
end
