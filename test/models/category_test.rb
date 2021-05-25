require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
    test "fail to create category without name" do
        category= Category.new(id:1)
        assert_not category.save, "Saved the category without a name"

    end

    test "Success to create category" do
        category= Category.new(name: "Andriod", id:1)
        assert category.save, "Saved the category Successfully"

    end

end