module Api
  module V1
    class VendorsController < Api::V1::ApplicationController
      def index
        render json: Vendor.all
      end

      def show
        render json: Vendor.find(params[:id])
      end
    end
  end
end
