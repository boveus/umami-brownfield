module Api
  module V1
    module Items
      class TagsController < Api::V1::ApplicationController
        def index
          render json: Item.find(params[:id]).tags.order(:id)
        end
      end
    end
  end
end
