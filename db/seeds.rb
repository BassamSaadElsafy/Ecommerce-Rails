# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@cat   = Category.create(name: "Laptops")
@brand = Brand.create(name: "Dell")
@store = Store.create(
    name: "Carrefour",
    summary: "Hyper Market",
    user_id: 1
)

Product.create(
    title: "pro1",
    price: 2000,
    quantity: 20,
    category_id: @cat.id,
    brand_id:@brand.id,
    store_id: @store.id,
)

Product.create(
    title: "pro2",
    price: 2000,
    quantity: 20,
    category_id: @cat.id,
    brand_id:@brand.id,
    store_id: @store.id,
)


Product.create(
    title: "pro3",
    price: 2000,
    quantity: 20,
    category_id: @cat.id,
    brand_id:@brand.id,
    store_id: @store.id,
)
