class Item < ApplicationRecord
  validates :name, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  has_many :shipments, through: :shipped_items
  has_many :shipped_items
end
