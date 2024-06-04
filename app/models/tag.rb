class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  scope :registed_post, ->(post_id) {
    joins(:post_tags).where(post_tags: { post_id: post_id })
  }

  # タグを複数件登録する
  # @param [Array<String>] tags
  # @param [Array<Int>] post_id
  # @return [void]
  def self.create_tags(tags, post_id)
    return if tags.blank?
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      PostTag.create!(post_id: post_id, tag_id: tag.id)
    end
  end
end
