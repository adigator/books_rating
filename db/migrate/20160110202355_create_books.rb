class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :year
      t.string :publisher
      t.string :genre
      t.string :cober
      t.string :description
      t.float :rating
      t.integer :rates
      t.string :country
      t.references :author

      t.timestamps null: false
    end
  end
end
