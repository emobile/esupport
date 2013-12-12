require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  setup do
    @bill = bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill" do
    assert_difference('Bill.count') do
      post :create, bill: { address1: @bill.address1, address2: @bill.address2, city: @bill.city, country: @bill.country, email: @bill.email, fax: @bill.fax, name: @bill.name, phone1: @bill.phone1, phone2: @bill.phone2, rfc: @bill.rfc, state: @bill.state, zip: @bill.zip }
    end

    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should show bill" do
    get :show, id: @bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bill
    assert_response :success
  end

  test "should update bill" do
    put :update, id: @bill, bill: { address1: @bill.address1, address2: @bill.address2, city: @bill.city, country: @bill.country, email: @bill.email, fax: @bill.fax, name: @bill.name, phone1: @bill.phone1, phone2: @bill.phone2, rfc: @bill.rfc, state: @bill.state, zip: @bill.zip }
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, id: @bill
    end

    assert_redirected_to bills_path
  end
end
