class ShippedItem < ApplicationRecord
  belongs_to :item
  belongs_to :shipment
  validates :shipment, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  validates_with QuantityValidator
end

# Custom validator to verify that we are not shipping more that what is available

class QuantityValidator < ActiveModel::Validator
  def validate(record)
    if record.quantity.nil?
      record.errors.add :quantity, 'cannot be blank'
    else
      unless record.quantity <= record.item.quantity
        record.errors.add :quantity, 'Not enough inventory quantity'
      end
    end
  end
end
