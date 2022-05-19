class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :title

      t.timestamps
    end

    add_reference :users, :account
  end
end
