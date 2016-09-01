Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  get 'searchmap', to: 'pages#searchmap'
  get 'friends', to: 'pages#friendslist'
  get 'results', to: 'pages#results'
  get 'guides/:id/filtered', to: 'guides#filteredfriends', as: 'filtered'
  #get 'friends', to: 'guides#friendslist'

  get 'friend_guides_list/:uid', to: 'pages#friend_guides_list', as: :friend_guides_list
  #get 'friend_guides_list/:uid', to: 'guides#friend_guides_list', as: :friend_guides_list
  get 'cards/:id/add', to:'cards#add_card_to_guide', as: 'add_card'
  patch 'cards/:id/update', to: 'cards#update_card_to_guide', as: 'update_card'

  resources :cards, only: [:new, :create, :edit, :update, :destroy]
  resources :guides
  resources :contacts, only: [:new, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
