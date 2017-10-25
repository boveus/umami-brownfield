module Api
  module V1
    module Vendors
      class UsersController < Api::V1::ApplicationController
        def index
          render json: Vendor.find(params[:id]).users.order(:id)
        end
      end
    end
  end
end
