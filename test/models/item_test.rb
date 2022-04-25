require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test 'should not save without a name' do
    item = Item.new(quantity: 10)
    item.valid?
    assert_not_empty item.errors[:name]
  end

  test 'should not save when is matching another inventory item' do
    item = Item.new(name: 'bob', quantity: 10)
    item.save
    item2 = Item.new(name: 'bob', quantity: 5)
    item2.valid?
    assert_not_empty item2.errors[:name]
  end

  test 'should not save with a negative quantity' do
    item = Item.new(name: 'bob', quantity: -5)
    item.valid?
    assert_not_empty item.errors[:quantity]
  end

  test 'should not save if quantity is blank' do
    item = Item.new(name: 'bob', quantity: nil)
    item.valid?
    assert_not_empty item.errors[:quantity]
  end

  test 'should accept only integer' do
    item = Item.new(name: 'bob', quantity: 1.5)
    item.valid?
    assert_not_empty item.errors[:quantity]
  end

  test 'should have quantity less than 8 bytes' do
    item = Item.new(name: 'bob', quantity: 1000000000000000000000000000000000000)
    item.valid?
    assert_not_empty item.errors[:quantity]
  end
end
