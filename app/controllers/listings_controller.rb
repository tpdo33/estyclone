class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  # create new listing
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      flash[:success] = "Listing has successfully been created"
      redirect_to listing_path(@listing)
   else
    flash[:errors] = @listing.errors.full_messages
    redirect_to '/listings'
  end
  end

  def update
    @listing.update(listing_params)
    redirect_to listing_path(@listing) 
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image)
    end
    def set_listing
      @listing = Listing.find(params[:id])
    end

end
