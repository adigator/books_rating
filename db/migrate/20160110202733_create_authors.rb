class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :surname
      t.float :rating
      t.integer :rates
      t.string :country
      t.references :book
      t.timestamps null: false
    end
  end
end
