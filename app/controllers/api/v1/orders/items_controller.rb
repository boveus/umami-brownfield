module Api
  module V1
    module Orders
      class ItemsController < ApplicationController
        def index
          @order = Order.find(params[:order_id])
          render json: @order.items
        end
      end
    end
  end
end