class Cart < ApplicationRecord
    has_one :user
    has_many :products
end