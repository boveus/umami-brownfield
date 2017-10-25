module Api
  module V1
    class ItemsController < Api::V1::ApplicationController
      def index
        render json: Item.all
      end
    end
  end
end
