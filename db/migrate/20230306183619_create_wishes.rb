class CreateWishes < ActiveRecord::Migration[7.0]
  def change
    create_table :wishes do |t|
      t.string :title
      t.rich_text :description
      t.references :wishlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
