class CreateSlideshopProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :slideshop_products do |t|
      t.string :shopify_product_id
      t.string :shopid
      t.text :data

      t.timestamps
    end
  end
end
