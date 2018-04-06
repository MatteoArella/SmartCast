Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get '/users/sign_in' => 'sessions#new', as: :sign_in
    delete '/users/sign_out' => 'sessions#destroy', as: :sign_out
    get '/users/sign_up' => 'users/registrations#new', as: :sign_up
    #get '/users/edit' => 'users/registrations#edit'
    get '/users/sign_up/role' => 'users/omniauth_callbacks#new_role', as: :new_user_role
    post '/users/sign_up/role' => 'users/omniauth_callbacks#create_role', as: :create_user_role
  end

  scope :users, :module => 'users' do
    get '/settings' => 'users#settings', as: :account_settings
    patch '/settings/update_username' => 'users#update_username', as: :update_username
    patch '/settings/update_password' => 'users#update_password', as: :update_password
  end

  resources :users
  
  resources :podcasts do 
    resources :episodes 
  end

  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  #root 'us'
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
