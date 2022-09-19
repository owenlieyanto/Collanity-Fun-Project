class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :size
      t.string :brands
      t.string :categories
      t.string :ingredients
      t.string :upc_code
      t.string :image_url

      t.timestamps
    end
  end
end
