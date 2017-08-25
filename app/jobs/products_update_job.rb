class ProductsUpdateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    shop.with_shopify_session do
      pid = webhook['id']
      if SlideshopProduct.exists?(:shopify_product_id => pid.to_s)
        proddata = {}
        proddata['title'] = webhook['title']
        proddata['id'] = webhook['id']
	
        if webhook.images.length
          proddata['src'] = webhook['images'][0].src
          proddata['width'] = webhook['images'][0].width
          proddata['height'] = webhook['images'][0].height
        end
 
        aproduct = SlideshopProduct.find_by(shopify_product_id: pid.to_s)
        aproduct.data = JSON.generate(proddata)
        aproduct.save
        
      end
    end
  end
end
