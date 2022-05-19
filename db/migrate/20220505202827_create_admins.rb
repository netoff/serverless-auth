class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_digest
      t.string :api_key
      t.string :account_title
      t.text :private_key

      t.timestamps

      t.index :email, unique: true
      t.index :api_key, unique: true
    end
  end
end
