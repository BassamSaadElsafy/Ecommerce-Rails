class CreateProducts < ActiveRecord::Migration[5.2]
    def change
        create_table :products do |t|
            t.string :title
            t.text :description
            t.decimal :price, :default => 0
            t.integer :quantity , :default => 0
            t.integer :rate
            t.integer :reviewers
            t.references :category
            t.references :brand
            t.references :store
            t.timestamps
        end
    end
end