ActionController::Routing::Routes.draw do |map|
  map.resources :users

  map.resource :session

  map.resources :users
  map.resource :session
  map.resources :prizes
  map.connect '/', :controller => 'account', :action => 'login'
  map.connect 'register/sponsor', :controller => 'account', :action => 'sponsor_registration'
  map.connect 'register/player', :controller => 'account', :action => 'player_registration'
  map.connect 'register', :controller => 'account', :action => 'player_registration'
  map.connect 'register/contact', :controller => 'account', :action => 'register_contact'
  map.connect 'login', :controller => 'account', :action => 'login'
  map.root :controller => 'account', :action => 'register_device'
  
  # The priority is based upon order of creation: first created -> highest priority.


  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
