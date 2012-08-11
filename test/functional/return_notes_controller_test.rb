require 'test_helper'

class ReturnNotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:return_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create return_note" do
    assert_difference('ReturnNote.count') do
      post :create, :return_note => { }
    end

    assert_redirected_to return_note_path(assigns(:return_note))
  end

  test "should show return_note" do
    get :show, :id => return_notes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => return_notes(:one).to_param
    assert_response :success
  end

  test "should update return_note" do
    put :update, :id => return_notes(:one).to_param, :return_note => { }
    assert_redirected_to return_note_path(assigns(:return_note))
  end

  test "should destroy return_note" do
    assert_difference('ReturnNote.count', -1) do
      delete :destroy, :id => return_notes(:one).to_param
    end

    assert_redirected_to return_notes_path
  end
end
