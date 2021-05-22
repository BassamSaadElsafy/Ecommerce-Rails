class ReviewsController < ApplicationController

    def rate
        if !(Rate.new).check_rate(Product.find(params[:id]), current_user.id)
            rate_update()
        else
            if Rate.where(user_id: current_user.id, product_id: params[:id]).empty?
                Rate.create(user_id: current_user.id, product_id: params[:id], rate: params[:rate].to_f)
            end
        end
        redirect_to request.referrer
    end

    def comment
        @product = Product.find(params[:id]) 
        if @product.check_order(@product, current_user.id)
            if Review.where(user_id: current_user.id, product_id: params[:id]).empty?
                Review.create(user_id: current_user.id, product_id: params[:id], comment: params[:comment])
            end
        end
        redirect_to request.referrer
    end

    def rate_update
        Rate.find_by(user_id: current_user.id, product_id: params[:id]).update(rate: params[:rate].to_f)
    end

    private
    def rate_params
        params.require(:product).permit(:rate, :comment)
    end

end