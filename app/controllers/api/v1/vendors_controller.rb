module Api
  module V1
    class VendorsController < Api::V1::ApplicationController
      def index
        render json: Vendor.all
      end
    end
  end
end
