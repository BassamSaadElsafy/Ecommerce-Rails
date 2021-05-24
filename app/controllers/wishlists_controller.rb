class WishlistsController < ApplicationController
  before_action :authenticate_user!

  #Get All Product in Wishlist for User
  def index
    @wishlist = Wishlist.where(:user_id => current_user.id)
    @wishlist_items = Wishitem.where(:wishlist_id => @wishlist)
  end

  #Add new Product to User Wishlist
  def create
    @wishlist = Wishlist.find_by(:user_id => current_user.id)
    @wishlist_items = Wishitem.new(:wishlist_id => @wishlist.id, :product_id => params[:prod_id])
    @wishlist_items.save
    if @wishlist_items.save
      redirect_to "/products?page=#{params[:page]}"
    end
  end

  #Delete Product from User Wishlist and My Wishlist
  def update
    @wishlist = Wishlist.where(:user_id => current_user.id)
    @wishlist_item = Wishitem.find_by(:wishlist_id => @wishlist, :product_id => params[:id])
    @wishlist_item.destroy
    if params.has_key?(:page)
      redirect_to "/products?page=#{params[:page]}"
    else
      redirect_to mywishlist_path
    end
  end
end