class StoreOrdersController < ApplicationController
    
    def index
        @orders = OrderProduct.where(store_id: current_user.store_id, state: "pending")
    end
  
    def update
        if params[:state].to_i == 1
            @order = OrderProduct.find(params[:id])
            if update_products(@order.order_id)
                @order.update(state: "approved")
                checkorder(@order.order_id)
                redirect_to request.referrer, notice: 'Approved'
            else
                redirect_to request.referrer, alert: 'did not match available quantity'
            end
        elsif params[:state].to_i  == 0
            @order = OrderProduct.find(params[:id])
            @order.update(state: "cancelled")
            checkorder(@order.order_id)
            redirect_to request.referrer, notice: 'cancelled'
        else
            redirect_to request.referrer, alert: 'wrong'
        end
    end
  
    private

        def store_orders_params
            params.permit(:id, :state)
        end

        def checkorder(order_id)
            @orders = OrderProduct.where(order_id: order_id)

            @orders.each do |order|
                if order.state == "cancelled"
                    Order.update(state: "cancelled")
                elsif order.state == "pending"
                else
                    Order.update(state: "approved")
                end
            end
        end

        def update_products(order_id)
            @orders = OrderProduct.where(order_id: order_id)
            @orders.each do |order|
                @product = Product.find(order.product_id)
                if @product.quantity >= order.quantity
                @product.update(quantity: @product.quantity-order.quantity)
                else
                    return false
                end
            end
        end
end
