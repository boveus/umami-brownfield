class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @items = Item.find(@cart.contents.keys)
  end

  def create
    item = Item.find(params[:item_id])

    @cart.add_item(item.id)
    session[:cart] = @cart.contents

    vendor = item.vendor
    params[:vendor_id] = vendor.id

    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.name)}."
    redirect_to vendor_items_path(vendor)
  end

  def update
    @cart.change_quantity(params[:button])
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:item_id])

    session[:cart].delete(params[:item_id])

    flash[:message] = "#{view_context.link_to item.name, item_path(item).html_safe} has been removed from your cart."

    redirect_to cart_path
  end

end
