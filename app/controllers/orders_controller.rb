class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    # if params[:search]
    #   @search_results_orders = Order.all[0..10]
    #   @par=params
    #   respond_to do |format|
    #     format.js { render partial: 'search-results'}
    #     # format.json  { render :json => @search_results_orders }
    #   end
    # else
    # @orders = Order.all
    # end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if params[:request_user]
       @user_all=User.all
      respond_to do |format|
        # format.json  { render :json => @user_all }
        format.js { render partial: 'get-users'}
      
      end

    else
    @order = Order.new
    end
  end

  # GET /orders/1/edit
  def edit

  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.users<<(User.find(params[:userid]))
    
# render  plain: params[:userid]
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:order_for, :from, :mimg,:image)
    end
end
