class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
