module Api
  module V1
    class TagsController < ApplicationController
      def index
        tags = Tag.eager_load(:posts).pluck(:id, :name)
        render json: tags
      end
    end
  end
end
