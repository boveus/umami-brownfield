class Vendor::OrdersController < ApplicationController
  def index
    @vendor = Vendor.find(vendor_order_params["vendor"])
    @orders = @vendor.unique_orders
  end

  def update
    Order.update(order_params[:id], status: order_params[:status])
    redirect_back(fallback_location: root_path)
  end

  def show
    @order = Order.find(vendor_order_params[:id])
    @items = @order.vendors_items(vendor_order_params[:vendor])
  end

  private

    def vendor_order_params
      params.permit(:vendor, :id)
    end

    def order_params
      params.permit(:status, :id)
    end
end
