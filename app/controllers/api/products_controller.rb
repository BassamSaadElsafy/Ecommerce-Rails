class Api::ProductsController < ApplicationController
    
    #Get All Products Info
    def index
        @products = Product.all
        render :json => @products
    end

    #Get Data of Certain Product
    def show
        @product = Product.find(params[:id])
        render :json => @product
    end
end