class Order < ApplicationRecord
    belongs_to :user
    has_one :address
    has_many :order_products
    has_many :products, through: :order_products
    validates :state, acceptance: { accept: ['inCart', 'pending', 'confirmed', 'delivered'] }
end