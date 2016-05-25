class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user
    
    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

      if @order.save
        flash[:success] = "Order has successfully been created"
        redirect_to listing_path(@listing)
      else
        flash[:errors] = @order.errors.full_messages
      redirect_to '/listings' 
    end
  end

  def update
    if @order.update(order_params)
      flash[:success] = "Order has successfully been updated" 
      redirect_to listing_path(@listing)
    else
      flash[:errors] = @order.errors.full_messages
     redirect_to '/listings'
    end
  end

  def destroy
    @order.destroy
  end

  private
    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
    def set_order
      @order = Order.find(params[:id])
    end
end
