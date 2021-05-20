class OrderProduct < ApplicationRecord
    belongs_to :product
    belongs_to :order
    validates :state, acceptance: { accept: ['inCart', 'pending', 'confirmed', 'delivered'] }
end