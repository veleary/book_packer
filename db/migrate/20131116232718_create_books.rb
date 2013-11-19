class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :price
      t.string :ship_weight
      t.string :isbn10
      t.string :isbn13
      t.string :publisher
      t.string :total_pages
      t.string :language
      t.string :description
      t.string :filename

      t.timestamps
    end
  end
end
  