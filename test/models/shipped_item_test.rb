require "test_helper"

class ShippedItemTest < ActiveSupport::TestCase
  test 'should create shipped item when all values are provided' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: @shipment, item: @item, quantity: 5)
    shipped_item.valid?
    assert_empty shipped_item.errors[:item]
  end

  test 'should not create shipped item when shipment is missing ' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: nil, item: @item, quantity: 5)
    shipped_item.valid?
    assert_not_empty shipped_item.errors[:shipment]
  end

  test 'should not create shipped item when item is missing ' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: @shipment, item: nil, quantity: 5)
    shipped_item.valid?
    assert_not_empty shipped_item.errors[:item]
  end

  test 'should not create shipped item when quantity is missing ' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: @shipment, item: @item, quantity: nil)
    shipped_item.valid?
    assert_not_empty shipped_item.errors[:quantity]
  end

  test 'shipped item should not have a negative quantity' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: @shipment, item: @item, quantity: -5)
    shipped_item.valid?
    assert_not_empty shipped_item.errors[:quantity]
  end

  test 'shipped item should not have more quantity than inventory' do
    create_item_shipment
    shipped_item = ShippedItem.new(shipment: @shipment, item: @item, quantity: 15)
    shipped_item.valid?
    assert_not_empty shipped_item.errors[:quantity]
  end

  def create_item_shipment
    @item = Item.create(quantity: 10, name: 'bob')
    @shipment = Shipment.create
  end
end
