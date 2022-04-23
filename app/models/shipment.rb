class Shipment < ApplicationRecord
  enum status: { pending: 0, shipped: 1 }
  has_many :shipped_items
  has_many :items, through: :shipped_items
end
