module Api
  module V1
    class OrdersController < Api::V1::ApplicationController
      def index
        render json: Order.all
      end
      
      def show
        @order = Order.find(params[:id])
        render json: @order
      end
    end
  end
end