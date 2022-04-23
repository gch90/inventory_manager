class CreateShippedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :shipped_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :shipment, null: false, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
