class ItemsController < ApplicationController

  def index
    @items = Item.all
    @tags = Tag.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
