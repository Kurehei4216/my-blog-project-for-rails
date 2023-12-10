module Api
  module V1
    class TagsController < ApplicationController
      def index
        @tag = Tag.includes(:posts)
        render json: @tag
      end
    end
  end
end
