class CreateCoupons < ActiveRecord::Migration[5.2]
    def change
        create_table :coupons do |t|
            t.string :code
            t.integer :expiration_type
            t.date :expiration_time
            t.integer :expiration_number
            t.integer :deduction_type
            t.integer :deduction_percentage
            t.integer :deduction_amount
            t.references :user, null: true, foreign_key: true
            t.references :product, null: true, foreign_key: true
            
            t.timestamps
        end
    end
end