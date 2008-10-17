ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :session
  map.resources :prizes
  map.connect '/', :controller => 'sessions', :action => 'new'
  map.connect 'sponsor/dashboard', :controller => 'prizes', :action => 'index'
  map.connect 'register/sponsor', :controller => 'account', :action => 'sponsor_registration'
  map.connect 'register/player', :controller => 'account', :action => 'player_registration'
  map.connect 'register', :controller => 'account', :action => 'player_registration'
  map.connect 'register/contact', :controller => 'account', :action => 'register_contact'
  map.connect 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.connect '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.root :controller => 'account', :action => 'register_device'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
