module Api
  module V1
    module Users
      class OrdersController < ApplicationController
        def index
          @user = User.find(params[:user_id])
          render json: @user.orders
        end
      end
    end
  end
end