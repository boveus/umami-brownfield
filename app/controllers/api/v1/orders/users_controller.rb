module Api
  module V1
    module Orders
      class UsersController < ApplicationController
        def index
          @order = User.find_by(params[:order_id])
          render json: @order.user
        end
      end
    end
  end
end