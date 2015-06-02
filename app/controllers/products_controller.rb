class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json, :js
  # GET /products
  # GET /products.json
  def index
    #@products = Product.paginate(:page => params[:page], :per_page => 3)
    @products = Product.rank(:row_order).all
    respond_to do |format|
      format.html # index.html.erb
      format.csv { render text: @products.to_csv }
      format.xls { render xls: @products.to_csv(col_sep: "\t") ,filename: "payments.xlsx"}
      format.xml  { render xml: @products }
      format.json { render json: @products }
      format.json { render bson: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  
  def show
    @product = Product.find(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.csv { render text: @product.to_csv }
    format.xls { render xls: @product.to_csv(col_sep: "\t") ,filename: "payments.xlsx"}
    format.json  { render :json => @product }
    format.xml  { render :xml => @product }
  end
end

  def update_row_order
    @product = Product.find(params[:thing][:product_id])
    @product.row_order_position = params[:thing][:row_order_position]
    @product.save
    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end



  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def preview
    render 'welcome/index'
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_id, :reference, :quantity, :row_order_position)
    end
end
