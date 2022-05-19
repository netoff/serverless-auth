class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.json :data
      t.boolean :subscribed, default: false
      t.string :plan_id
      t.string :stripe_id
      t.references :admin

      t.timestamps

      t.index [:admin_id, :email], unique: true
    end
  end
end
