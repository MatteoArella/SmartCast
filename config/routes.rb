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

  concern :votable do
    put 'like', action: :upvote, as: :like
    put 'dislike', action: :downvote, as: :dislike
  end

  concern :commentable do
    #post 'comments', action: :comment
    #delete 'comments/:id', action: :uncomment
    resources :comments
  end

  concern :shareable do
    post 'facebook_share', action: :facebook_share
  end

  resources :podcasts, concerns: :votable do
    resources :audio_episodes, :controller => 'episodes/audio_episodes', :type => 'AudioEpisode', concerns: [:votable, :commentable, :shareable]
    resources :video_episodes, :controller => 'episodes/video_episodes', :type => 'VideoEpisode', concerns: [:votable, :commentable, :shareable]
  end

  root 'welcome#index'
  get 'faq' => 'faq#index'
end
