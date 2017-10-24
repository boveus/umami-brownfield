class Vendor::ItemsController < ApplicationController
  def index
    @vendor = Vendor.find_by(slug: params[:vendor]) || Vendor.find(params[:vendor])
    @items = @vendor.items
    @tags = Tag.all
  end

  def new
    @vendor = Vendor.find(params[:vendor])
    @item   = Item.new
    @tags   = Tag.all
  end

  def create
    @vendor = Vendor.find(params[:vendor])
    @item   = Item.new(item_params)
    @item.vendor = @vendor
    @tags   = Tag.all
    if @item.save
      flash[:notice] = "#{@item.name} Created."
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    @vendor = Vendor.find(params[:vendor])
    @item = Item.find(params[:id])
    @tags = Tag.all
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_back(fallback_location: root_path)
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

  private

  def item_params
    params.require(:item).permit(:name, :price, :image, :description, tag_ids: [])
  end
end
