require 'test_helper'

class WorkshopsControllerTest < ActionController::TestCase
  setup do
    @workshop = workshops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop" do
    assert_difference('Workshop.count') do
      post :create, workshop: { address1: @workshop.address1, address2: @workshop.address2, city: @workshop.city, country: @workshop.country, description: @workshop.description, email1: @workshop.email1, email2: @workshop.email2, fax: @workshop.fax, name: @workshop.name, phone1: @workshop.phone1, phone2: @workshop.phone2, state: @workshop.state, zip: @workshop.zip }
    end

    assert_redirected_to workshop_path(assigns(:workshop))
  end

  test "should show workshop" do
    get :show, id: @workshop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop
    assert_response :success
  end

  test "should update workshop" do
    put :update, id: @workshop, workshop: { address1: @workshop.address1, address2: @workshop.address2, city: @workshop.city, country: @workshop.country, description: @workshop.description, email1: @workshop.email1, email2: @workshop.email2, fax: @workshop.fax, name: @workshop.name, phone1: @workshop.phone1, phone2: @workshop.phone2, state: @workshop.state, zip: @workshop.zip }
    assert_redirected_to workshop_path(assigns(:workshop))
  end

  test "should destroy workshop" do
    assert_difference('Workshop.count', -1) do
      delete :destroy, id: @workshop
    end

    assert_redirected_to workshops_path
  end
end
