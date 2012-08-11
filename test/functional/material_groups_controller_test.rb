require 'test_helper'

class MaterialGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:material_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material_group" do
    assert_difference('MaterialGroup.count') do
      post :create, :material_group => { }
    end

    assert_redirected_to material_group_path(assigns(:material_group))
  end

  test "should show material_group" do
    get :show, :id => material_groups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => material_groups(:one).to_param
    assert_response :success
  end

  test "should update material_group" do
    put :update, :id => material_groups(:one).to_param, :material_group => { }
    assert_redirected_to material_group_path(assigns(:material_group))
  end

  test "should destroy material_group" do
    assert_difference('MaterialGroup.count', -1) do
      delete :destroy, :id => material_groups(:one).to_param
    end

    assert_redirected_to material_groups_path
  end
end
