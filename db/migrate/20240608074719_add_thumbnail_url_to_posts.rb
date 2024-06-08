class AddThumbnailUrlToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :thumbnail_url, :string, null: true
  end
end
