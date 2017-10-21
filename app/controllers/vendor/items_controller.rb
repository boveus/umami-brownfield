class Vendor::ItemsController < ApplicationController
  def index
    @vendor = Vendor.find_by(slug: params[:vendor]) || Vendor.find(params[:vendor])
    @items = @vendor.items
    @tags = Tag.all
  end

  def edit
     @item = Item.find(params[:id])
     @tags = Tag.all
  end
end
