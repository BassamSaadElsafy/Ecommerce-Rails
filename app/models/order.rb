class Order < ApplicationRecord
    has_one :user
    has_and_belongs_to_many :products
end