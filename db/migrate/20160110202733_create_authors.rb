class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :surname
      t.string :rating
      t.string :country
      t.references :book
      t.timestamps null: false
    end
  end
end
