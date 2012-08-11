require 'test_helper'

class CardCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => CardCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CardCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    CardCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to card_category_url(assigns(:card_category))
  end
  
  def test_edit
    get :edit, :id => CardCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    CardCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CardCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    CardCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CardCategory.first
    assert_redirected_to card_category_url(assigns(:card_category))
  end
  
  def test_destroy
    card_category = CardCategory.first
    delete :destroy, :id => card_category
    assert_redirected_to card_categories_url
    assert !CardCategory.exists?(card_category.id)
  end
end
