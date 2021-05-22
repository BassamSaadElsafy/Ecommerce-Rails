require 'faker'

8.times do
    Category.create(name: Faker::Device.platform)
    Brand.create(name: Faker::Device.manufacturer)
end

Store.create(
    name: Faker::Device.manufacturer,
    summary: Faker::Hacker.say_something_smart,
    user_id: 1
)

25.times do |t|
    Product.create(
        title: Faker::Device.platform,
        price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
        quantity: Faker::Number.between(from: 10, to: 50),
        description: Faker::Hacker.say_something_smart,
        category_id: Faker::Number.between(from: 1, to:6),
        brand_id: Faker::Number.between(from: 1, to: 6),
        store_id: 1,
    )
end

2.times do |t|
    Rate.create(
        rate: Faker::Number.between(from: 1, to:5),
        user_id: 1,
        product_id: t
    )
    Review.create(
        comment: Faker::Hacker.say_something_smart,
        user_id: 1,
        product_id: t
    )
end