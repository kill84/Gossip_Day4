Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'gossip#index'
  get '/team', to: 'team#show'
  get '/contact', to: 'contact#show'
  get '/welcome/:id', to: 'welcome#say_hello', as: 'welcome'
  resources :gossip do
    resources :comment
    resources :likes, only: [:new, :create, :destroy]
  end
  resources :user
  resources :city
  resources :session, only: [:new, :create, :destroy]
end
