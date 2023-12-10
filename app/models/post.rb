class Post < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  scope :is_not_deleted, -> {
    where(is_deleted: false)
  }

  scope :search_by_keyword, ->(search_word) {
    where(["title LIKE(?) OR content LIKE(?)", "%#{search_word}%", "%#{search_word}%"])
  }
end
