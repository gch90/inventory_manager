require "test_helper"

class ShippedItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get shipped_items_create_url
    assert_response :success
  end
end
