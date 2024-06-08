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

      def show
        post = Post.eager_load(:tags).where(id: params[:id]).first
        render json: {
          post: post,
          tags: post&.tags
        }
      end

      def create
        tags = params.dig(:tags)
        category_id = params.dig(:category)

        ActiveRecord::Base.transaction do
          post = Post.create!(post_params)
          Tag.create_tags(tags, post.id) if tags.present?
          category = Category.find_by(id: category_id)
          PostCategory.create!(post_id: post.id, category_id: category.id) if category.present?
        end

        render json: { message: '記事の投稿に成功しました' }

        rescue ActiveRecord::RecordInvalid => e
          render json: { message: '投稿に失敗しました', error: e.message }
      end

      def update
        tags, post = params.values_at(:tags, :post)
        registed_tags = Tag.registed_post(post[:id]).index_by(&:name)

        ActiveRecord::Base.transaction do
          @post = Post.find(post[:id])
          @post.update!(update_params)
          tags&.each do |tag|
            next if registed_tags[tag[:name]].present?

            tag = Tag.find_or_create_by(name: tag[:name])
            PostTag.create!(post_id: @post.id, tag_id: tag.id)
          end
        end
        render json: { message: '記事の更新に成功しました' }

        rescue ActiveRecord::RecordInvalid => e
          render json: { message: '更新に失敗しました', error: e.message }
      end

      def delete
        id = params.dig(:id)
        post = Post.find(id)
        post.update!(is_deleted: true)

        render json: { message: '記事の削除に成功しました' }

        rescue ActiveRecord::RecordInvalid => e
          render json: { message: '削除に失敗しました', error: e.message }
      end

      private

      def search_params
        params.require(:q).permit(:title)
      end

      def post_params
        params.require(:post).permit(:title, :content, :thumbnail_url)
      end

      def update_params
        raise params.inspect
        params.require(:post).permit(:id, :title, :content, :is_publish, :thumbnail_url)
      end
    end
  end
end
