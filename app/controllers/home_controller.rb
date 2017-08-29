class HomeController < ShopifyApp::AuthenticatedController
  def index
    @shopdomain = ShopifyAPI::Shop.current().domain
  end
end
