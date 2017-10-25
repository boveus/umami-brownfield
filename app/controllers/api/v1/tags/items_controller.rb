module Api
  module V1
    module Tags
      class ItemsController < ApplicationController
        def index
          @tag = Tag.find(params[:tag_id])
          render json: @tag.items
        end
      end
    end
  end
end
