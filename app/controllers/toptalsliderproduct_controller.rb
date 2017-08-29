class ToptalsliderproductController < ShopifyApp::AuthenticatedController
  skip_around_action :shopify_session, only: [:list]
  skip_before_action :login_again_if_different_shop, only: [:list]

  def list
    processed = []
    
    storeid = params[:shop]
    if storeid==''
      storeid = ShopifyAPI::Shop.current().domain 
    end
    
    if storeid == 'all'
      allproducts = SlideshopProduct.all
    else
      allproducts = SlideshopProduct.where(["shopid = :shopidval", { shopidval:storeid}])
    end

    processed.push({'domain':storeid})
    if allproducts
      allproducts.each do |p|
        pmetadata = JSON.parse(p.data)
        processed.push(pmetadata)
      end
    end

    #log.debug "Prodcut list for toptalslider"
    render json: processed
    #render layout: false
  end

  def post
    result = {}
    if SlideshopProduct.exists?(:shopify_product_id => params[:id])
      result['status'] = 'ok'
      result['message'] = 'Product already exists'
    else
      aproduct = ShopifyAPI::Product.find(params[:id].to_i, params: { fields:'id,title,images' })
      
      if aproduct
        result['status'] = 'ok'
	result['product'] = aproduct
        curshopid = ShopifyAPI::Shop.current().domain
        
        asliderproduct = {}
        asliderproduct['title'] = aproduct.title
        asliderproduct['id'] = aproduct.id
	if aproduct.images.length
          asliderproduct['src'] = aproduct.images[0].src
          asliderproduct['width'] = aproduct.images[0].width
          asliderproduct['height'] = aproduct.images[0].height
        end
        
        asliderproduct['domain'] = curshopid        
	createdSlideshopProd = SlideshopProduct.create(shopify_product_id: params[:id], shopid: curshopid, data:JSON.generate(asliderproduct) )         
        result['message'] = 'Product has been successfully added'
        result['product'] = asliderproduct 
      else
        result['status'] = 'error'
        result['message'] = 'Product id does not exist'
      end
    end
    
    render json: result
  end

  def delete
    processed = []
    render json: processed
  end
  
  def shop_domain
    request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
  end
end
