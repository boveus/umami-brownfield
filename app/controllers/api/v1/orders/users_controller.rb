module Api
  module V1
    module Orders
      class UsersController < ApplicationController
        def index
          @order = Order.find(params["order_id"])
          render json: @order.user
        end
      end
    end
  end
end