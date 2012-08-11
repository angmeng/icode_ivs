require 'test_helper'

class MaterialCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_category" do
    assert_difference('MaterialCategory.count') do
      post :create, :material_category => { }
    end

    assert_redirected_to material_category_path(assigns(:material_category))
  end

  test "should show material_category" do
    get :show, :id => material_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => material_categories(:one).to_param
    assert_response :success
  end

  test "should update material_category" do
    put :update, :id => material_categories(:one).to_param, :material_category => { }
    assert_redirected_to material_category_path(assigns(:material_category))
  end

  test "should destroy material_category" do
    assert_difference('MaterialCategory.count', -1) do
      delete :destroy, :id => material_categories(:one).to_param
    end

    assert_redirected_to material_categories_path
  end
end
