class ToptalsliderproductController < ShopifyApp::AuthenticatedController

  def list
    processed = []
    allproducts = SlideshopProduct.all
    
    allproducts.each do |p|
      pmetadata = JSON.parse(p.data)
      processed.push(p)
    end
   
    render json: processed
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
        curshopid = ShopifyAPI::Shop.current().id
        asliderproduct = {}
        asliderproduct['title'] = aproduct.title
        asliderproduct['id'] = aproduct.id
	if aproduct.images.length
          asliderproduct['src'] = aproduct.images[0].src
          asliderproduct['width'] = aproduct.images[0].width
          asliderproduct['height'] = aproduct.images[0].height
        end
        
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

end
