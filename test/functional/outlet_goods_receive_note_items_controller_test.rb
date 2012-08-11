require 'test_helper'

class OutletGoodsReceiveNoteItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlet_goods_receive_note_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet_goods_receive_note_item" do
    assert_difference('OutletGoodsReceiveNoteItem.count') do
      post :create, :outlet_goods_receive_note_item => { }
    end

    assert_redirected_to outlet_goods_receive_note_item_path(assigns(:outlet_goods_receive_note_item))
  end

  test "should show outlet_goods_receive_note_item" do
    get :show, :id => outlet_goods_receive_note_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outlet_goods_receive_note_items(:one).to_param
    assert_response :success
  end

  test "should update outlet_goods_receive_note_item" do
    put :update, :id => outlet_goods_receive_note_items(:one).to_param, :outlet_goods_receive_note_item => { }
    assert_redirected_to outlet_goods_receive_note_item_path(assigns(:outlet_goods_receive_note_item))
  end

  test "should destroy outlet_goods_receive_note_item" do
    assert_difference('OutletGoodsReceiveNoteItem.count', -1) do
      delete :destroy, :id => outlet_goods_receive_note_items(:one).to_param
    end

    assert_redirected_to outlet_goods_receive_note_items_path
  end
end
