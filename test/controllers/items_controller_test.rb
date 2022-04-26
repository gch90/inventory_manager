require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @item = items(:one)
    @item_in_shipment = items(:two)
  end

  # called after every single test
  teardown do
    # reseting controller cache
    Rails.cache.clear
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get show" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count", 1) do
      post items_url, params: { item: { name: "test", quantity: 10 } }
    end
    assert_response :redirect
    assert_redirected_to item_path(Item.last)
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete item_url(@item)
    end
    assert_redirected_to root_path
  end

  test "should not destroy item in shipment" do
    assert_difference("Item.count", 0) do
      delete item_url(@item_in_shipment)
    end
  end

  test "should update item" do
    patch item_url(@item), params: { item: { name: "updated", quantity:10 } }

    assert_redirected_to item_path(@item)
    # Reload association to fetch updated data and assert that title is updated.
    @item.reload
    assert_equal "updated", @item.name
    assert_equal 10, @item.quantity
  end
end
