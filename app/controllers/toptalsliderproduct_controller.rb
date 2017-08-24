class ToptalsliderproductController < ShopifyApp::AuthenticatedController

  def list
    processed = []
    render json: processed
  end

  def post
    result = {}
    if SlideshopProduct.exists?(:shopify_product_id => params[:id])
      result['status'] = 'ok'
      result['message'] = 'Product already exists'
    else
      product = ShopifyAPI::Product.find(params[:id].to_i)
      
      if product
        result['status'] = 'ok'
	result['message'] = ShopifyAPI::Shop.current().id
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
