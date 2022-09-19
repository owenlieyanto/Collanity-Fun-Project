class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  
  # GET & POST /landing_page
  def landing_page
    if (params[:upc_code].present?) # if (params.has_key?(:upc_code))
      @upc_code = params[:upc_code]
      
      require 'net/http'
      source = "http://world.openfoodfacts.org/api/v0/product/#{@upc_code}.json"
      resp = Net::HTTP.get_response(URI.parse(source))
      data = resp.body
      data = JSON.parse(data)
      
      # product not found
      if (data["status"] == 0)  
        flash.now.alert = "Product #{@upc_code} not found"
        return
      end

      # upc_code already exist
      if (Product.where(upc_code: @upc_code).present?)  
        flash.now.alert = "Product #{@upc_code} already exist"
        return
      end

      # for code optimization
      data = data["product"]

      # insert data into database
      @product = Product.new
      @product.brands = data["brands"]
      @product.categories = data["categories"]
      @product.image_url = data["image_url"]

      # looping through ingredients
      ingredients = []
      data["ingredients"].each do |ingredient|
        ingredients.append(ingredient['text'])
      end
      @product.ingredients = ingredients.join(", ")

      @product.product_name = data["product_name"]
      @product.size = data["quantity"]
      @product.upc_code = @upc_code
      
      # save to db
      respond_to do |format|
        if @product.save
          format.html { redirect_to :root, notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def test_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_name, :size, :brands, :categories, :ingredients, :upc_code, :image_url)
    end
end
