module Api
  module V1
    module Items
      class OrdersController < Api::V1::ApplicationController
        def index
          render json: Item.find(params[:id]).orders
        end
      end
    end
  end
end
