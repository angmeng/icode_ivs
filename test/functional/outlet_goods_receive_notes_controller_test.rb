require 'test_helper'

class OutletGoodsReceiveNotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlet_goods_receive_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet_goods_receive_note" do
    assert_difference('OutletGoodsReceiveNote.count') do
      post :create, :outlet_goods_receive_note => { }
    end

    assert_redirected_to outlet_goods_receive_note_path(assigns(:outlet_goods_receive_note))
  end

  test "should show outlet_goods_receive_note" do
    get :show, :id => outlet_goods_receive_notes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outlet_goods_receive_notes(:one).to_param
    assert_response :success
  end

  test "should update outlet_goods_receive_note" do
    put :update, :id => outlet_goods_receive_notes(:one).to_param, :outlet_goods_receive_note => { }
    assert_redirected_to outlet_goods_receive_note_path(assigns(:outlet_goods_receive_note))
  end

  test "should destroy outlet_goods_receive_note" do
    assert_difference('OutletGoodsReceiveNote.count', -1) do
      delete :destroy, :id => outlet_goods_receive_notes(:one).to_param
    end

    assert_redirected_to outlet_goods_receive_notes_path
  end
end
