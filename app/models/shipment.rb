class Shipment < ApplicationRecord
  has_many :shipped_items
  has_many :items, through: :shipped_items, dependent: :destroy
  enum status: { pending: 0, shipped: 1 }
end
