class CreateRates < ActiveRecord::Migration[5.2]
    def change
        create_table :rates do |t|
            t.decimal :rate, :default => 0, precision: 10, scale: 2
            t.references :user, null: false, foreign_key: true
            t.references :product, null: false, foreign_key: true
            t.timestamps
        end
    end
end