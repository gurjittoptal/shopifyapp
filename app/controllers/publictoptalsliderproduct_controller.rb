class ToptalsliderproductController < ShopifyApp::AuthenticatedController
  skip_around_action :shopify_session, only: [:list]
  skip_before_action :login_again_if_different_shop, only: [:list]

  def list
    processed = []
    allproducts = SlideshopProduct.all
    processed.push({'domain':params[:shop]})    
    allproducts.each do |p|
      pmetadata = JSON.parse(p.data)
      processed.push(pmetadata)
    end
    log.debug "Prodcut list for toptalslider"  
    render json: processed
    #render layout: false
  end

end
