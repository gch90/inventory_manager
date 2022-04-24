
class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  has_many :shipments, through: :shipped_items
  has_many :shipped_items, dependent: :destroy
end
