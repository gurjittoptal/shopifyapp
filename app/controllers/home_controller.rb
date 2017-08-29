class HomeController < ShopifyApp::AuthenticatedController
  def index
    @storeid = ShopifyAPI::Shop.current().domain
  end
end
