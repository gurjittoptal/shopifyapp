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
      result['status'] = 'adding'
    end
    
    render json: result
  end

  def delete
    processed = []
    render json: processed
  end

end
