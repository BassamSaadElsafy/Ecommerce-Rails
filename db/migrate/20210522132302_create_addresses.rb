class CreateAddresses < ActiveRecord::Migration[5.2]
    def change
        create_table :addresses do |t|
            t.string :billing
            t.string :address
            t.references :user, null: false, foreign_key: true
            t.references :order, null: false, foreign_key: true
            t.timestamps
        end
    end
end