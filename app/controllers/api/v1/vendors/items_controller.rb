module Api
  module V1
    module Vendors
      class ItemsController < Api::V1::ApplicationController
        def index
          render json: Vendor.find(params[:id]).items
        end
      end
    end
  end
end
