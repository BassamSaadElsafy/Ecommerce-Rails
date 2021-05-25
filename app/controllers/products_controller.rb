class ProductsController < ApplicationController
    
    ##authentication required for this operations
    before_action :authenticate_user!, :except => [:show, :index]
    before_action :filter_parameters
    self.page_cache_directory = :domain_cache_directory
    caches_page :show

    @@searched_item = nil

    #Get all Products or #Filtared Product
    def index
        @@searched_term = params[:search]
        @products = Product.search(params[:search])
        if current_user
            @wishlist = Wishlist.where(:user_id => current_user.id)
        end
        @wishlist_items = Wishitem.where(:wishlist_id => @wishlist)
        @products = Product.paginate(page: params[:page], per_page: 12).order("created_at DESC").search(params[:search])
    end

    #Get New Product Page
    def new
    end

    #Add New Product
    def create
        @product = Product.new(product_params)
        @product.store_id = current_user.store.id
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
        if check_orders()
            @product = Product.find(params[:id])
            @product.destroy
            redirect_to products_path
        else
            redirect_to products_path, alert: "cannot delete product in order process"
        end
    end

    #Filter Products By Parameters
    def filter_parameters
        @categories = Category.all
        @brands = Brand.all
        @stores = Store.all
    end

    #Filter Products By Price
    def filter_products
        if params[:categories].present? || params[:brands].present? || params[:stores].present? || params[:price_min].present? || params[:price_max].present?
            @products = Product.search(@@searched_item)
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
            if params[:price_min].present?
                @products = (@products.nil?) ? Product.where("price >= ?", params[:price_min]) : @products.where("price >= ?", params[:price_min])
            end
            if params[:price_max].present?
                @products = (@products.nil?) ? Product.where("price <= ?", params[:price_max]) : @products.where("price <= ?", params[:price_max])
            end
            @filtered = true
            @products
        else
            @filtered = false
            @products = Product.search(@@searched_item).page params[:page]
        end
        @products = @products.paginate(page: params[:page]).search(params[:search])
        if current_user
            @wishlist = Wishlist.where(:user_id => current_user.id)
        end
        @wishlist_items = Wishitem.where(:wishlist_id => @wishlist)
        respond_to do |format|
            format.html { render :index}
        end
    end
    
    private
        def product_params
            params.require(:product).permit(:title, :rate, :description, :price, :quantity, :category_id, :brand_id, :image, :page)
        end

        def domain_cache_directory
            Rails.root.join("public", request.domain)
        end
        
        def check_orders
            (OrderProduct.where(state: "pending", product_id: params[:id]).or(OrderProduct.where(state: "confirmed", product_id: params[:id]))).empty?
        end
end