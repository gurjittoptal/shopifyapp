class ProductsDeleteJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    shop.with_shopify_session do
    
      pid = webhook['id']    
      aproduct = SlideshopProduct.find_by(shopify_product_id: pid.to_s)
      aproduct.destroy

    end
  end
end
