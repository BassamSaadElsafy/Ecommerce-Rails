class ProductsController < ApplicationController
    
    ##authentication required for this operations
    before_action :authenticate_user!, :except => [:show, :index]

    #Get all Products or #Filtared Product
    def index
        @products = Product.search(params[:search])
    end

    #Get New Product Page
    def new
    end

    #Add New Product
    def create
        @product = Product.new(product_params)
        @product.store_id = 1
        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end

    #Show Product Details
    def show
        @product = Product.find(params[:id])
    end

    #Show Edit Page
    def edit
        @product = Product.find(params[:id])
    end

    #Update Product Details
    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit'
        end
    end

    #Delete Product Details
    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_path
    end
    
    private
        def product_params
            params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :brand_id, :image, :search)
        end
end