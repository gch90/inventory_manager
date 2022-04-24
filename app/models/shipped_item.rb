# Custom validator to verify that we are not shipping more that what is available
class QuantityValidator < ActiveModel::Validator
  def validate(record)
    unless record.quantity.nil? || record.quantity <= record.item.quantity
      record.errors.add :quantity, 'Not enough inventory quantity'
    end
  end
end

class ShippedItem < ApplicationRecord
  belongs_to :item
  belongs_to :shipment
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :shipment, presence: true

  validates_with QuantityValidator
end
