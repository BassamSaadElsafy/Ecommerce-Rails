class ReviewsController < ApplicationController

    def rate
        if Rate.find_by(:product_id => params[:id], :user_id => current_user.id)
            rate_update()
        else
            Rate.create(user_id: current_user.id, product_id: params[:id], rate: params[:rate].to_f)
        end
        redirect_to request.referrer
    end

    def comment
        @product = Product.find(params[:id]) 
        Review.create(user_id: current_user.id, product_id: params[:id], comment: params[:comment])
        redirect_to request.referrer
    end

    def rate_update
        Rate.find_by(user_id: current_user.id, product_id: params[:id]).update(rate: params[:rate].to_f)
    end

    def destroy
        @review = Review.find(params[:review_id])
        @review.destroy
        redirect_to request.referrer
    end
end