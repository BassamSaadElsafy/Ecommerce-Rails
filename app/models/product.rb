class Product < ApplicationRecord
    has_one :category
    has_one :brand
    has_one :store
    has_many :images
    has_and_belongs_to_many :orders
end