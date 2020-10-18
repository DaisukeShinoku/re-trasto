Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'homes#top'
  get '/about',   to: 'homes#about'
  get '/term',   to: 'homes#term'
  get '/privacy',   to: 'homes#privacy'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  post '/guest_sign_in', to: 'sessions#new_guest'
  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  scope module: :user do
    get  '/signup',  to: 'users#new'
    resources :users, :only => [:index, :show, :create, :edit, :update, :destroy]do
      member do
        get :bookmark, to: 'bookmarks#index'
        get :to_go_list, to: 'to_go_lists#index'
        get :story_bookmark, to: 'story_bookmarks#index'
        get :favorite, to: 'favorites#index'
        get :following, :followers
        get :tweets
        get :stories
      end
    end
    resources :messages, :only => [:create]
    resources :relationships,       only: [:create, :destroy]
    resources :categories, :only => [:index]
    resources :tweets, :only => [:create, :show, :index, :destroy] do
      resources :tweet_comments, only: [:destroy]
      resource :favorites, only: [:create, :destroy]
      member do
        resources :tweet_comments, only: [:create]
      end
    end
    resources :rooms, :only => [:create, :show, :index] do
      member do
        get :show_additionally, to: 'rooms#show_additionally'
      end
    end
    resources :houses do
      member do
        resources :house_comments, only: [:create, :index]
      end
      resources :stories do
        member do
          resources :story_comments, only: [:create, :index]
          resources :story_bookmarks, only: [:create, :destroy]
        end
        resources :story_comments, only: [:destroy]
      end
      resources :house_comments, only: [:destroy]
      resource :bookmarks, only: %i[create destroy]
      resource :to_go_lists, only: %i[create destroy]
      get :bookmarks, on: :collection
    end
  end

  namespace :admin do
    resources :users do
      member do
        get :tweets
        get :stories
      end
    end
    resources :houses do
      member do
        resources :house_comments, only: [:index]
      end
      resources :stories, :only => [:destroy, :show, :index] do
        member do
          resources :story_comments, only: [:index]
        end
        resources :story_comments, only: [:destroy]
      end
      resources :house_comments, only: [:destroy]
    end
    resources :categories
    resources :tweets do
      resources :tweet_comments, only: [:destroy]
    end
  end
end
