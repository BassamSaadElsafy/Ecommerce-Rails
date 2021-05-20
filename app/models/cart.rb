class Cart < ApplicationRecord
    belongs_to :product
    belongs_to :user
    has_many :listed_items
    has_many :products , through: :listed_items
end