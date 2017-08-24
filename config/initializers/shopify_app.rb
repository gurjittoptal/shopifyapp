ShopifyApp.configure do |config|
  config.application_name = "Toptal Shopifly Slideshow"
  config.api_key = ENV['api_key']
  config.secret = ENV['secret']
  config.scope = "read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
