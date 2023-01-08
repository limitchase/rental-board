class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :listing_type
      t.string :location
      t.string :author
      t.string :avatar
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
