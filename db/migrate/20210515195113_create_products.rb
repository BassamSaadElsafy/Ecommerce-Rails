class CreateProducts < ActiveRecord::Migration[5.2]
    def change
        create_table :products do |t|
            t.string :title
            t.text :description
            t.decimal :price
            t.integer :quantity
            t.references :category
            t.references :brand
            t.references :store
            t.timestamps
        end
    end
end