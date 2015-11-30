require 'test_helper'

class ClientNeedsControllerTest < ActionController::TestCase
  setup do
    @client_need = client_needs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_needs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_need" do
    assert_difference('ClientNeed.count') do
      post :create, client_need: { cost: @client_need.cost, description: @client_need.description, name: @client_need.name }
    end

    assert_redirected_to client_need_path(assigns(:client_need))
  end

  test "should show client_need" do
    get :show, id: @client_need
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_need
    assert_response :success
  end

  test "should update client_need" do
    put :update, id: @client_need, client_need: { cost: @client_need.cost, description: @client_need.description, name: @client_need.name }
    assert_redirected_to client_need_path(assigns(:client_need))
  end

  test "should destroy client_need" do
    assert_difference('ClientNeed.count', -1) do
      delete :destroy, id: @client_need
    end

    assert_redirected_to client_needs_path
  end
end
