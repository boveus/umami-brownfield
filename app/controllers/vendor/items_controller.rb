class Vendor::ItemsController < ApplicationController
  def index
    @items = Vendor.find_by(slug: params[:vendor]).items
    @tags = Tag.all
    render "items/index"
  end
end
