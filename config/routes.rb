Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  get '/posts', to: redirect('/'), as: "posts"
  resources :posts, except: [:index] do
    resources :votes, only: [:create]
  end

  resources :users, only: [:show] do
    resources :posts, only: [:index]
  end

  #resources :sessions, only: [:new, :create, :destroy]

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

end
