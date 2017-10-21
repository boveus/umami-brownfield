class Vendor::ItemsController < ApplicationController
  def index
    @vendor = Vendor.find_by(slug: params[:vendor]) || Vendor.find(params[:vendor])
    @items = @vendor.items
    @tags = Tag.all
    render "items/index"
  end
end
