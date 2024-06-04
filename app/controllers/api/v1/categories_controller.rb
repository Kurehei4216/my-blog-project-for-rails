module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        @categories = Category.eager_load(:posts)
        render json: @categories
      end

      def posts
        category = Category.eager_load(:posts).find(params[:id])
        render json: {
          category: category,
          posts: category&.posts || []
        }
      end

    end
  end
end
