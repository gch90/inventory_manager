class ShippedItem < ApplicationRecord
  belongs_to :item
  belongs_to :shipment
  # validates :shipped_quantity, numericality: { less_than: :item_quantity}
end
