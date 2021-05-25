class CartsController < ApplicationController
    
    def index
      @cart = Order.find_by(user_id: current_user.id, state: "inCart")
    end

    def create
      if Product.find(params[:id]).quantity == 0
        redirect_to products_path, alert: 'Cannot add it, no available items for your order' 
      elsif Product.find(params[:id]).quantity < (params[:quantity]).to_i
        redirect_to request.referer, alert: 'Cannot add it, there is no enough quantity in stock!!' 
      else 
        @order = Order.find_by(user_id: current_user.id, state: "inCart")
        if @order.nil?
          @order =Order.create(user_id: current_user.id, state: "inCart")
        end
        update(@order, params[:id], params[:quantity])
        redirect_to request.referrer, notice: 'Cart Changed successfully'
      end
    end

    def edit
    end

    def update(order, prod_id, quantity)
      if quantity.nil?
        orderprod(order.id, prod_id)
      else
        orderprod(order.id, prod_id, quantity.to_i)
      end
    end

    def destroy
      @order = Order.find(params[:id])
      @orderprod = OrderProduct.find_by(order_id: @order.id)
      @orderprod.destroy
      @order.destroy
      redirect_to request.referrer, notice: 'Deleted successfully'
    end
  
    def remove
      @orderprod = OrderProduct.find(params[:id])
      orderid = @orderprod.order_id
      @orderprod.destroy
      if OrderProduct.where(order_id: orderid).empty?
        Order.find_by(id: orderid, state: "inCart").destroy
      end
      redirect_to request.referrer, notice: 'Removed successfully'
    end

    private
        def cart_params
            params.permit(:id, :quantity)
        end

        def orderprod (ord_id, prd_id, quantity = 1)
          @orderprod = OrderProduct.find_by(order_id: ord_id, product_id: prd_id)
      
          if @orderprod.nil?
            @product = Product.find(prd_id)
            Order.find(ord_id).products << @product
            @orderprod = OrderProduct.find_by(order_id: ord_id, product_id: prd_id)
            @orderprod.update(store_id: @product.store.id, state: "inCart", quantity: quantity)
          elsif @orderprod.quantity > 0
            unless @orderprod.quantity == 1 && quantity == -1
              @orderprod.update(quantity: @orderprod.quantity+quantity)
            end
          end
        end
end