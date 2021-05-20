class CreateOrders < ActiveRecord::Migration[5.2]
    def change
        create_table :orders do |t|
            t.integer :quantity
            t.string :state
            t.references :order
            t.references :product
            t.references :user
            t.string :store_id
            t.timestamps
        end
    end
end