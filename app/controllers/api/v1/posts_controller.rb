module Api
  module V1
    class PostsController < ApplicationController
      def index
        @post = Post.is_not_deleted
        render json: @post
      end

      def search
        render json: Post.search_by_keyword(params[:keyword])
      end

      def create
        tags = params.dig(:tags)
        category_id = params.dig(:category)

        ActiveRecord::Base.transaction do
          post = Post.create!(post_params)
          tags.each do |tag_name|
            tag = Tag.find_or_create_by(name: tag_name)
            PostTag.create!(post_id: post.id, tag_id: tag.id)
          category = Category.find(category_id)
          PostCategory.create!(post_id: post.id, category_id: category.id)
          end
        end

        render json: { message: '投稿成功しました' }

        rescue ActiveRecord::RecordInvalid => e
          render json: { message: '投稿に失敗しました', error: e.message }

      end

      private

      def search_params
        params.require(:q).permit(:title)
      end

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
