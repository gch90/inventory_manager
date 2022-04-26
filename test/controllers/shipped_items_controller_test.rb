require "test_helper"

class ShippedItemsControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @item_pending = items(:two)
    @item_shipped = items(:three)
    @shipment_pending = shipments(:one)
    @shipment_shipped = shipments(:two)
    @shipped_item_pending = shipped_items(:one)
    @shipped_item_shipped = shipped_items(:two)
  end

  # called after every single test
  teardown do
    # reseting controller cache
    Rails.cache.clear
  end

  test "should create Shipped Item and adjust quantity" do
    assert_difference("ShippedItem.count", 1) do
      post shipped_items_url, params: { shipped_item: {
        item: @item_pending.id,
        shipment: @shipment_pending.id,
        quantity: 1
      } }
    end
    @item_pending.reload
    assert_equal 4, @item_pending.quantity
    assert_response :redirect
    assert_redirected_to shipment_path(@shipment_pending)
  end

  test "should not create Shipped Item if shipment shipped" do
    assert_difference("ShippedItem.count", 0) do
      post shipped_items_url, params: { shipped_item: {
        item: @item_pending.id,
        shipment: @shipment_shipped.id,
        quantity: 1
        } }
    end
    @item_pending.reload
    assert_equal 5, @item_pending.quantity
  end

  test "should destroy shipped item and return inventory" do
    assert_difference("ShippedItem.count", -1) do
      delete shipped_item_url(@shipped_item_pending)
    end
    @item_pending.reload
    assert_equal 6, @item_pending.quantity
    assert_redirected_to shipment_path(@shipment_pending)
  end

  test "should not destroy shipped item if item shipped" do
    assert_difference("ShippedItem.count", 0) do
      delete shipped_item_url(@shipped_item_shipped)
    end
  end
end
