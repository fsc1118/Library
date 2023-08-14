class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :book_name, null: false
      t.string :author_last_name
      t.string :author_first_name
      t.integer :edition
      t.string :isbn, null: false
      t.boolean :isAvailable, null: false
      t.timestamps
    end
  end
end
