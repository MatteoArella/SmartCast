Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get '/users/sign_in' => 'sessions#new', as: :sign_in
    delete '/users/sign_out' => 'sessions#destroy', as: :sign_out
    get '/users/sign_up' => 'users/registrations#new', as: :sign_up
    get '/users/sign_up/role' => 'users/omniauth_callbacks#new_role', as: :new_user_role
    post '/users/sign_up/role' => 'users/omniauth_callbacks#create_role', as: :create_user_role
    patch '/users/update_username' => 'users/registrations#update_username', as: :update_username
    patch '/users/update_password' => 'users/registrations#update_password', as: :update_password
    patch '/user/update_avatar' => 'users/registrations#update_avatar', as: :update_avatar
  end

  #scope :users, :module => 'users' do
  namespace :users do
    get '/:id' => 'users#show'
  end

  resources :users
  
  resources :podcasts do 
    resources :episodes 
  end

  root 'welcome#index'
  get 'faq' => 'faq#index'
  
end
