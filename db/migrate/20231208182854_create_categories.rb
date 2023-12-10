class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.boolean :is_deleted, null: false, default: false
      t.timestamps
    end
  end
end
