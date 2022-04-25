class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than: 922_337_203_685_477_580_7
  }
  has_many :shipments, through: :shipped_items
  has_many :shipped_items, dependent: :destroy
end
