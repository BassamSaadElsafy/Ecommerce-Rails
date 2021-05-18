class OrderProduct < ApplicationRecord
    belongs_to :products
    belongs_to :orders
end