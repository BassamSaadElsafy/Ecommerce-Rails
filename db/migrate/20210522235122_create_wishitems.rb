class CreateWishitems < ActiveRecord::Migration[5.2]
  def change
    create_table :wishitems do |t|
      t.references :wishlist
      t.references :product
      t.timestamps
    end
  end
end
