class CreateOrderProducts < ActiveRecord::Migration[5.2]
    def change
        create_table :order_products do |t|
            t.references :order
            t.references :product
            t.string :store_id
            t.integer :quantity, :default => 0
            t.string :state, :default => "inCart"
            t.timestamps
        end
    end
end