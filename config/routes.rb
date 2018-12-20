Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create_from_omniauth'

  get '/posts', to: redirect('/'), as: "posts"
  resources :posts, except: [:index] do
    collection do
      get 'ordered_by_votes'
    end
    resources :votes, only: [:create]
  end

  resources :users, only: [] do
    resources :posts, only: [:index]
  end
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

end
