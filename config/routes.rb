Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root to: "vendors#index"

 resources :vendors, only: [:index, :show]

 resources :items,  only: [:index, :show]
 resources :tags,   only: [:index, :show]
 resources :users,  only: [:new, :create]
 resources :orders, only: [:index, :show, :create]

 namespace :admin do
   resources :users, only: [:edit, :update]
   resources :tags
   resources :items
   resources :orders #we may take some routes out once it's more clear what we need.
 end

 get 'admin/dashboard' => 'admin/base#dashboard'
 get "/dashboard"      => "users#dashboard"
 get "/login"          => "sessions#new"
 post "/login"         => "sessions#create"
 delete "/logout"      => "sessions#destroy"
 get "/cart"           => "carts#show"
 post "/cart"          => "carts#create"
 patch "/cart"         => "carts#update"
 delete "/cart"        => "carts#destroy"
 
 

 get '/auth/google_oauth2', as: :google_login
 get '/auth/twitter', as: :twitter_login
 get '/auth/facebook', as: :facebook_login
 get 'auth/:provider/callback', to: 'sessions#create'
 get 'auth/failure', to: redirect('/')
 get 'signout', to: 'sessions#destroy', as: 'signout'
 resources :confirmations, only: [:new, :create]
 namespace :users do
   get '/password-confirmation', to: 'password#reset', as: :password_reset
   patch '/password-confirmation/update', to: 'password#update', as: :password_patch
   get '/password-edit',  to: 'password#edit', as: :password_edit
 end
 get 'password-reset', to: 'password#index'
 post 'password-reset', to: 'password#new'

 namespace :vendor, path: ':vendor', as: :vendor do
   resources :items, only: [:index]
 end

 get "/:name"          => "tags#show"

 # resources :sessions, only: [:create, :destroy]
 # resource :home, only: [:show]

end
