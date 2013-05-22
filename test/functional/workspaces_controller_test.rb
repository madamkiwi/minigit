require 'test_helper'

class WorkspacesControllerTest < ActionController::TestCase
  setup do
    @workspace = workspaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workspaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workspace" do
    assert_difference('Workspace.count') do
      post :create, :workspace => { :description => @workspace.description, :title => @workspace.title }
    end

    assert_redirected_to workspace_path(assigns(:workspace))
  end

  test "should show workspace" do
    get :show, :id => @workspace
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @workspace
    assert_response :success
  end

  test "should update workspace" do
    put :update, :id => @workspace, :workspace => { :description => @workspace.description, :title => @workspace.title }
    assert_redirected_to workspace_path(assigns(:workspace))
  end

  test "should destroy workspace" do
    assert_difference('Workspace.count', -1) do
      delete :destroy, :id => @workspace
    end

    assert_redirected_to workspaces_path
  end
end
