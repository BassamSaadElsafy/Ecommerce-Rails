# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create(name: "Laptops")
Brand.create(name: "Dell")
Store.create(
    name: "Carrefour",
    summary: "Hyper Market",
    user_id: 1
)

Product.create(
    title: "Dell Inspiron",
    description: "New Laptop",
    price: 6500,
    quantity: 20,
    category_id: 1,
    brand_id: 1,
    store_id: 1
)
