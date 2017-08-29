Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  delete '/toptalsliderproduct/:pid' => 'toptalsliderproduct#delete'
  post '/toptalsliderproduct/' => 'toptalsliderproduct#post'
  get '/toptalsliderproduct/' => 'toptalsliderproduct#list'
end
