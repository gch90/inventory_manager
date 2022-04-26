# Custom validator to verify that we are not shipping more that what is available
class QuantityValidator < ActiveModel::Validator
  def validate(record)
    if record.item.nil? || record.quantity.blank?
      record.errors.add :item, 'Can\'t be blank' and return
    elsif record.quantity > record.item.quantity
      record.errors.add :quantity, 'Not enough in inventory'
    end
  end
end

class ShippedItem < ApplicationRecord
  belongs_to :item
  belongs_to :shipment
  validates :item, presence: true
  validates :shipment, presence: true
  validates :quantity, presence: true, numericality: {
    greater_than: 0,
    only_integer: true,
    less_than: 922_337_203_685_477_580_7
  }
  validates_with QuantityValidator
end
