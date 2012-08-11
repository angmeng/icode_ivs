require 'test_helper'

class ProjectSupervisorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_supervisors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_supervisor" do
    assert_difference('ProjectSupervisor.count') do
      post :create, :project_supervisor => { }
    end

    assert_redirected_to project_supervisor_path(assigns(:project_supervisor))
  end

  test "should show project_supervisor" do
    get :show, :id => project_supervisors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => project_supervisors(:one).to_param
    assert_response :success
  end

  test "should update project_supervisor" do
    put :update, :id => project_supervisors(:one).to_param, :project_supervisor => { }
    assert_redirected_to project_supervisor_path(assigns(:project_supervisor))
  end

  test "should destroy project_supervisor" do
    assert_difference('ProjectSupervisor.count', -1) do
      delete :destroy, :id => project_supervisors(:one).to_param
    end

    assert_redirected_to project_supervisors_path
  end
end
