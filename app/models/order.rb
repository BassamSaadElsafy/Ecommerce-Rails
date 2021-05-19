class Order < ApplicationRecord
    has_one :user
    has_many :order_products
    has_many :products, through: :order_products
end