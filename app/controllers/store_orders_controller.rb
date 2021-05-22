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
        if @order.state == "pending" || @order.state == "confirmed"
            if @order.order.state == "pending"
                update_orders("confirmed")
                redirect_to request.referrer, notice: 'confirmed'
            end
            if @order.order.state == "confirmed"
                update_orders("delivered")
                redirect_to request.referrer, notice: 'delieverd'
            end
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

        def update_orders(stat)
            @order.update(state: stat)
            @orders = OrderProduct.where(order_id: @order.order_id)
            if @orders.where(state: @order.order.state).empty?
                Order.find(@order.order_id).update(state: stat)
                if stat == "delivered"
                    Address.find_by(order_id: @order.order_id).destroy
                end
            end
        end
end
