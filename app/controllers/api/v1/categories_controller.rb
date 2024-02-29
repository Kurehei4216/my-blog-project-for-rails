module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        @categories = Category.eager_load(:posts)
        render json: @categories
      end
    end
  end
end
