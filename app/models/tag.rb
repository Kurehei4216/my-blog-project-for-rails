class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  scope :registed_post, ->(post_id) {
    joins(:post_tags).where(post_tags: { post_id: post_id })
  }
end
