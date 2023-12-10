class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :is_publish, null: false, default: false
      t.datetime :published_at
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end
  end
end
