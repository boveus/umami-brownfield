class ItemsController < ApplicationController

  def index
    binding.pry
    @items = Item.all
    @tags = Tag.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
