# -*- encoding : utf-8 -*-
L2013::Application.routes.draw do
  get 'instagram/callback'
  post 'instagram/callback'

  get '/popup/:id', to: 'frontend#post'

  root to: 'frontend#index'

  match 'images/:order/:page', to: 'frontend#index'

  match "ohitsyou", to: 'frontend#view'

  match "lookwhativedone/:order/:page", to: 'frontend#view'

  match "nothing here", to: 'frontend#blank'

  match "obey", to: 'frontend#rules'
  match "about", to: 'frontend#about'
  match "gifts", to: 'frontend#gifts'
  match "lipton", to: 'frontend#lipton'

  match 'like/:photo_id', to: 'frontend#like'

  match "auth/failure", to: 'frontend#failure'

  match "login", to: 'frontend#login'

  match "auth/:provider/callback", to:'frontend#callback'

  match "soooclose", to: 'frontend#final_stage', via: [:put, :get]

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match '*path' => redirect('/') unless Rails.env.development?

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
