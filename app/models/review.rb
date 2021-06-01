class Review < ApplicationRecord
    belongs_to :user
    belongs_to :product
    validates :comment, presence: true
end