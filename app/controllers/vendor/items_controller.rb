class Vendor::ItemsController < ApplicationController
  def index
    @items = Vendor.find_by(slug: params[:vendor]).items
    render "items/index"
  end
end
