class HomeController < ShopifyApp::AuthenticatedController
  def index
    @shopdomain = ShopifyAPI::Shop.current().domain
    #@products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    #@webhooks = ShopifyAPI::Webhook.find(:all)
  end
end
