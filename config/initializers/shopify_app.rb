ShopifyApp.configure do |config|
  config.application_name = "Toptal Shopifly Slideshow"
  config.api_key = ENV['api_key']
  config.secret = ENV['secret']
  config.scope = "read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
  config.webhooks = [
    {topic: 'products/update', address: 'https://tpshp.herokuapp.com/webhooks/products_update', format: 'json'},
    {topic: 'products/delete', address: 'https://tpshp.herokuapp.com/webhooks/products_delete', format: 'json'},
  ]
  config.scripttags = [
    {event:'onload', src: 'https://tpshp.herokuapp.com/toptalslider.js'}
  ]
end
