class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /listings or /listings.json
  # def index
  #   # @listings = Listing.all
  #   @listings = Listing.all.order("created_at desc")
  # end

  def index
    if(params.has_key?(:listing_type))
      @listings = Listing.where(listing_type: params[:listing_type]).order("created_at desc")
    elsif(params.has_key?(:price))
      # @listings = Listing.order("price")
      if params[:price] == "ascending"
        @listings = Listing.order("price")
      else
        @listings = Listing.order("price").reverse
      end
    elsif params[:search] && params[:search] != ""
      @listings = Listing.where(["lower(location) like ? OR lower(title) like ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%"])

      if params[:minprice] && params[:minprice] != "" && params[:maxprice] && params[:maxprice] != ""
        @listings = Listing.where(["lower(location) like ? OR lower(title) like ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%"]).where("price >=  ?", params[:minprice].to_i).where("price <=  ?", params[:maxprice].to_i).order("price")
      elsif params[:minprice] && params[:minprice] != ""
        @listings = Listing.where(["lower(location) like ? OR lower(title) like ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%"]).where("price >=  ?", params[:minprice].to_i).order("price")
      elsif params[:maxprice] && params[:maxprice] != ""
        @listings = Listing.where(["lower(location) like ? OR lower(title) like ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%"]).where("price <=  ?", params[:maxprice].to_i).order("price")
      end
    elsif params[:minprice] && params[:minprice] != "" && params[:maxprice] && params[:maxprice] != ""
      @listings = Listing.where("price >=  ?", params[:minprice].to_i).where("price <=  ?", params[:maxprice].to_i).order("price")
    elsif params[:minprice] && params[:minprice] != ""
      @listings = Listing.where("price >=  ?", params[:minprice].to_i).order("price")
    elsif params[:maxprice] && params[:maxprice] != ""
      @listings = Listing.where("price <=  ?", params[:maxprice].to_i).order("price")
    else
      @listings = Listing.all.order("created_at desc")
    end
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    # @listing = Listing.new
    @listing = current_user.listings.build
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    # @listing = Listing.new(listing_params)
    @listing = current_user.listings.build(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:title, :description, :listing_type, :location, :author, :avatar, :price, :minprice, :maxprice, :search, images: [])
    end
end
