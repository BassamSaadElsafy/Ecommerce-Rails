class StoreOrdersController < ApplicationController
    
    def index
        if !(current_user.store).nil?
            @store_orders = OrderProduct.where(store_id: current_user.store.id)
            @orders = @store_orders.where(state: "pending").or(@store_orders.where(state: "confirmed"))
        else
            redirect_to orders_path, alert: 'you do not have store!'
        end
    end

    def update
        @order = OrderProduct.find(params[:id])
        if @order.order.state == "pending"
            update_orders("confirmed")
            redirect_to request.referrer, notice: 'confirmed'
        end
        if @order.order.state == "confirmed"
            update_orders("delivered")
            redirect_to request.referrer, notice: 'delieverd'
        end
    end
    
    private
        def update_orders(stat)
            @order.update(state: stat)
            @orders = OrderProduct.where(order_id: @order.order_id)
            if @orders.where(state: @order.order.state).empty?
                Order.find(@order.order_id).update(state: stat)
            end
        end
end