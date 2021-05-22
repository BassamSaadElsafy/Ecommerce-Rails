class ProductsController < ApplicationController
    
    ##authentication required for this operations
    before_action :authenticate_user!, :except => [:show, :index]
    before_action :filter_parameters
    self.page_cache_directory = :domain_cache_directory
    caches_page :show
    
    #Get all Products or #Filtared Product
    def index
        @searched_term = params[:search]
        @products = Product.search(params[:search])
    end

    #Get New Product Page
    def new
    end

    #Add New Product
    def create
        @product = Product.new(product_params)
        @product.store_id = current_user.store.id
        # @product.store_id = current_user.store.id
    
        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end

    #Show Product Details
    def show
        @product = Product.find(params[:id])
        @rate = Rate.new
        @reviews = Review.where(product_id: params[:id])
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

    def rate
        @product = Product.find(params[:id])

        @product.update(reviewers: (@product.reviewers+1) )
        @product.update(rate: ((@product.rate + params[:rate].to_i)/2))

        redirect_to @product
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
        
        unless @searched_term.nil? || @searched_term.empty?
            @products = Product.search(@searched_term)
        end

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
            params.require(:product).permit(:title, :rate, :description, :price, :quantity, :category_id, :brand_id, :image)
        end

        def domain_cache_directory
            Rails.root.join("public", request.domain)
        end
end