class CreateAuthorsBooks < ActiveRecord::Migration
  def change
    create_join_table :authors, :books, id: false do |t|
      t.index :author_id
      t.index :book_id
    end
  end
end
