module Api
  module V1
    class TagsController < ApplicationController
      def index
        tags = Tag.eager_load(:posts).map do |tag|
          { id: tag.id, name: tag.name, post_id: tag.posts.pluck(:id) }
        end
        render json: tags
      end

      def posts
        tag = Tag.eager_load(:posts).find(params[:id])
        render json: tag.as_json(include: { posts: { only: [:id, :title, :created_at] }})
      end
    end
  end
end
