class Review < ApplicationRecord
    belongs_to :user
    belongs_to :product

    validates :comment, presence: true

    def check_reviews(prod, id)
        Review.where(product_id: prod.id, user_id: id).empty?
    end
end