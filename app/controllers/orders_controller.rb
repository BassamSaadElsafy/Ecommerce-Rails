class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, :except => [:show, :index]

    def index
        @orders = Order.all()
       
    end

    def new
        @order = Order.new
    end

    def create
        @order = Order.new(order_params)
        respond_to do |format|
          if @order.save
            format.html { redirect_to @order, notice: 'Order was successfully created.' }
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end
      end

    def show
        @order = Order.find(params[:id])
    end

    def edit
        @order = Order.find(params[:id])
        @orderprod = OrderProduct.find_by(order_id: @order.id)
        @product = Product.find(@orderprod.product_id)
    end

    def update
      @order = Order.find(params[:id])

      @orderprod = OrderProduct.find_by(order_id: @order.id)
      @product = Product.find(@orderprod.product_id)

      @order.update(order_params)
      @product.update(quantity: @product.quantity-@order.quantity)  
  
      if @order.update(state: "Inorder")
          redirect_to @order
      else
          render 'edit'
      end
    end

      def destroy
        @order.destroy
        respond_to do |format|
          format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.fetch(:order, {}).permit(:search)
    end
end