class Vendor::ItemsController < ApplicationController
  def index
    @vendor = Vendor.find_by(slug: params[:vendor]) || Vendor.find(params[:vendor])
    @items = @vendor.items
    @tags = Tag.all
  end

  def edit
     @vendor = Vendor.find(params[:vendor])
     @item = Item.find(params[:id])
     @tags = Tag.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "#{@item.name} updated."
      redirect_to item_path(@item)
    else
      @tags = Tag.all
      render :edit
    end
  end

  def item_params
    params.require(:item).permit(:name, :price, :image, :description, tag_ids: [])
  end
end
