require "test_helper"

class ShippedItemTest < ActiveSupport::TestCase
  test 'should create shipped item when all values are provided' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: @shipment, item: @item, quantity: 5)
    shipped_item.valid?
    assert_empty shipped_item.errors[:item]
  end

  def create_item_shipment
    @item = Item.create(quantity: 10, name: 'bob')
    @shipment = Shipment.create
  end
end
