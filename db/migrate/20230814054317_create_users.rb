class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :token, null: false
      t.boolean :isAdmin, null: false

      t.timestamps
    end
  end
end
