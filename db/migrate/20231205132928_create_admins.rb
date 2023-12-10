class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :role

      t.index :username, unique: true
      t.index :email, unique: true

      t.timestamps
    end
  end
end
