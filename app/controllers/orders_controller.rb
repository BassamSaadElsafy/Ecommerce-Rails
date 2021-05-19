class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
        @orders = Order.all()
    end

    def new
        @order = Order.new
    end

    def create

        @order = Order.new()
        @order.state = "pending"
        @order.user_id = 1 #current_user_id
        @product = Product.find(params[:id])
        @order.products << @product

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

    def showCart 
        @items = Array.new
        @total_payment = 0
        @products = Order.where(state: "pending").collect(&:products).flatten
        @products.each do |product|
            @items.push(product)
            @total_payment += (product.price * product.quantity)
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
      params.fetch(:order, {}).permit(:id)
    end
end