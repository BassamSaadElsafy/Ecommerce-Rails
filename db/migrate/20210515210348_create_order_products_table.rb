class CreateOrderProductsTable < ActiveRecord::Migration[5.2]
    def change
        create_table :orders_products do |t|
            t.references :order
            t.references :product
    
            t.timestamps
        end
    end
end