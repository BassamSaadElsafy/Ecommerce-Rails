class ProductsController < ApplicationController
    
    ##authentication required for this operations
    before_action :authenticate_user!, :except => [:show, :index]

    #Get all Products or #Filtared Product
    def index
        if(params[:filter])
            @products = Product.filter(params[:filter], params[:filterby])
        else
            @products = Product.search(params[:search])
        end
    end

    #Get New Product Page
    def new
    end

    #Add New Product
    def create
        @product = Product.new(product_params)
        @product.store_id = current_user.store_id
        # @product.reviewers = 0
        # @product.rate = 0
        @product.save
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

    #Filter Products By Parameters
    def filter_parameters
        @categories = Category.all
        @brands = Brand.all
        @stores = Store.all
    end

    #Filter Products By Price
    def filter_products
        if params[:categories].present? || params[:brands].present? || params[:stores].present?
            if params[:categories].present?
                @products = (@products.nil?) ? Product.where(category_id: params[:categories]) : @products.where(category_id: params[:categories])
            end
            if params[:brands].present?
                puts "brands = #{@brands}"
                @products = (@products.nil?) ? Product.where(brand_id: params[:brands]) : @products.where(brand_id: params[:brands])
            end   
            if params[:stores].present?
                @products = (@products.nil?) ? Product.where(store_id: params[:stores]) : @products.where(store_id: params[:stores])
            end
        else
            @products = Product.all
        end
        respond_to do |format|
            format.js
        end
    end
    
    private
        def product_params
            params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :brand_id, :store_id, :image)
        end
end