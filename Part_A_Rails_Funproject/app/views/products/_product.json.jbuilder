json.extract! product, :id, :product_name, :size, :brands, :categories, :ingredients, :upc_code, :image_url, :created_at, :updated_at
json.url product_url(product, format: :json)
