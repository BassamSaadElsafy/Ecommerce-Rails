class Address < ApplicationRecord
    belongs_to :user
    belongs_to :order
    validates :address, :billing, presence: true,
            length: { minimum: 5 }
end