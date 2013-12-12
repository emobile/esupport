require 'test_helper'

class ComputersControllerTest < ActionController::TestCase
  setup do
    @computer = computers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:computers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create computer" do
    assert_difference('Computer.count') do
      post :create, computer: { brand: @computer.brand, charger: @computer.charger, color: @computer.color, hard_drive: @computer.hard_drive, keyboard: @computer.keyboard, memory: @computer.memory, model: @computer.model, monitor: @computer.monitor, mouse: @computer.mouse, serial_number: @computer.serial_number, type: @computer.type, units: @computer.units, usb: @computer.usb }
    end

    assert_redirected_to computer_path(assigns(:computer))
  end

  test "should show computer" do
    get :show, id: @computer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @computer
    assert_response :success
  end

  test "should update computer" do
    put :update, id: @computer, computer: { brand: @computer.brand, charger: @computer.charger, color: @computer.color, hard_drive: @computer.hard_drive, keyboard: @computer.keyboard, memory: @computer.memory, model: @computer.model, monitor: @computer.monitor, mouse: @computer.mouse, serial_number: @computer.serial_number, type: @computer.type, units: @computer.units, usb: @computer.usb }
    assert_redirected_to computer_path(assigns(:computer))
  end

  test "should destroy computer" do
    assert_difference('Computer.count', -1) do
      delete :destroy, id: @computer
    end

    assert_redirected_to computers_path
  end
end
