class OrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    unless @order
      render file: "/public/404"
    end
  end

  def create
    items = []
    @cart.contents.each do |k, v|
      v.times do
        items << Item.find(k.to_i)
      end
    end
    order = current_user.orders.create
    order.items << items
    session.delete(:cart)
    redirect_to orders_path
  end

end
