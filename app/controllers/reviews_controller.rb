class ReviewsController < ApplicationController

    def rate
        if Rate.where(user_id: current_user.id, product_id: params[:id]).empty?
            Rate.create(user_id: current_user.id, product_id: params[:id], rate: params[:rate].to_f)
        end
        redirect_to request.referrer
    end

    def comment
        if Review.where(user_id: current_user.id, product_id: params[:id]).empty?
            Review.create(user_id: current_user.id, product_id: params[:id], comment: params[:comment])
        end
        redirect_to request.referrer
    end

    private
    def rate_params
        params.require(:product).permit(:rate, :comment)
    end

end