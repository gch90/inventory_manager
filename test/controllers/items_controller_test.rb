require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  # was the web request successful?
  # was the user redirected to the right page?
  # was the user successfully authenticated?
  # was the appropriate message displayed to the user in the view?
  # was the correct information displayed in the response?

  # called before every single test
  setup do
    @item = items(:one)
  end

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
  end

  test "should create item" do
    # Reuse the @item instance variable from setup
    assert_difference("Item.count", 1) do
      post items_url, params: { item: { name: "test", quantity: 10 } }
    end
  end

  test "should show item" do
    # Reuse the @item instance variable from setup
    get item_url(@item)
    assert_response :success
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete item_url(@item)
    end

    assert_redirected_to root_path
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
