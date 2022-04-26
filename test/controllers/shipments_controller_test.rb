require 'test_helper'

class ShipmentsControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @shipment = shipments(:one)
    @item = items(:two)
    @shipment_shipped = shipments(:two)
  end

  # called after every single test
  teardown do
    # reseting controller cache
    Rails.cache.clear
  end

  test "should get index" do
    get shipments_url
    assert_response :success
  end

  test "should get show" do
    get shipment_url(@shipment)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipment_url(@shipment)
    assert_response :success
  end

  test "should create shipment" do
    assert_difference("Shipment.count", 1) do
      post shipments_url
    end
    assert_response :redirect
    assert_redirected_to shipments_path
  end

  test "should show shipment" do
    get shipment_url(@shipment)
    assert_response :success
  end

  test "should destroy shipment and return inventory" do
    assert_difference("Shipment.count", -1) do
      delete shipment_url(@shipment)
    end
    @item.reload
    assert_equal 6, @item.quantity
    assert_redirected_to shipments_path
  end

  test "should update shipment" do
    patch shipment_url(@shipment), params: { shipment: { status: 1 } }
    assert_redirected_to edit_shipment_path(@shipment)
    # Reload association to fetch updated data and assert that title is updated.
    @shipment.reload
    assert_equal "shipped", @shipment.status
  end

  test "should not destroy shipment if shipped" do
    delete shipment_url(@shipment_shipped)
    @shipment_shipped.reload
    assert_instance_of Shipment, @shipment_shipped
  end
end
