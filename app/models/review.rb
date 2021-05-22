class Review < ApplicationRecord
    belongs_to :user
    belongs_to :product
    validates :comment, presence: true

    def check_reviews(prod, user)
        Review.where(product_id: prod.id, user_id: user.id).empty?
    end
    
    def user_review(prod, user)
        Review.find_by(product_id: prod.id, user_id: user.id)
    end
end