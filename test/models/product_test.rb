require 'test_helper'

class ProductTest < ActionDispatch::IntegrationTest
    
    test "should not create product without required" do
        product = Product.create
        assert_not product.save
    end
    
    test "should not create product without description" do
        product = Product.create()
        assert_equal product.errors.messages[:description], ["can't be blank"]
    end

    test "should create product with description" do
        product = Product.create({description: "desc"})
        assert_not_equal product.errors.messages[:description], ["can't be blank"]
    end

    test "should not create product without title" do
        product = Product.create()
        assert_not product.errors.messages[:title].empty?
    end

    test "should create product with title, min length is 5" do
        product = Product.create({title: "title"})
        assert product.errors.messages[:title].empty?
    end

    test "should not create product without title length less than 5" do
        product = Product.create({title: "ti"})
        assert_equal product.errors.messages[:title], ["is too short (minimum is 5 characters)"]
    end

    test "should create product with brand_id" do
        product = Product.create({brand_id: 2})
        assert product.errors.messages[:brand_id].empty?
    end

    test "should not create product without brand_id  " do
        product = Product.create
        assert_not product.errors.messages[:brand_id].empty?
    end

    test "should create product with category_id" do
        product = Product.create({category_id: 2})
        assert product.errors.messages[:category_id].empty?
    end

    test "should not create product without category_id  " do
        product = Product.create
        assert_not product.errors.messages[:category_id].empty?
    end

    test "should create product with store" do
        product = Product.create({store: Store.new})
        assert product.errors.messages[:store].empty?
    end

    test "should not create product without store  " do
        product = Product.create
        assert_not product.errors.messages[:store].empty?
    end
    test "should create product with category" do
        product = Product.create({category: Category.new})
        assert product.errors.messages[:category].empty?
    end

    test "should not create product without category  " do
        product = Product.create
        assert_not product.errors.messages[:category].empty?
    end

    test "should create product with brand" do
        product = Product.create({brand: Brand.new})
        assert product.errors.messages[:brand].empty?
    end

    test "should not create product without brand  " do
        product = Product.create
        assert_not product.errors.messages[:brand].empty?
    end

    test "should create product with price" do
        product = Product.create({price: 5})
        assert product.errors.messages[:price].empty?
    end

    test "should not create product without price" do
        product = Product.create
        assert_equal product.price, 0
    end

    test "should not create product when price is not a number" do
        product = Product.create({price: "price"})
        assert_equal product.errors.messages[:price], ["is not a number"]
    end

    test "should create product with quantity" do
        product = Product.create({quantity: 5})
        assert product.errors.messages[:quantity].empty?
    end

    test "should not create product without quantity" do
        product = Product.create
        assert_not_equal product.errors.messages[:quantity], 0
    end

    test "should not create product when quantity is string" do
        product = Product.create({quantity: "quantity"})
        assert_not product.errors.messages[:quantity].empty?
    end
end