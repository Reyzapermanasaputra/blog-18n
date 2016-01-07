Rails.application.routes.draw do

  get 'uploads/index'

  get 'uploads/format'
  get 'articles/progress'
  get 'articles/progress/status', to: 'articles#progress', as: 'progress_status'

  get 'sign_in' => "sessions#new", as: :sign_in
  get 'logot' => "sessions#destroy", as: :logot

  get 'sign_up' => "users#new", as: :sign_up

  root to: 'articles#index'
  resources :users
  resources :sessions
  resources :articles do 
    collection {post :import}
    collection do
      get 'articles/:status' => 'articles#index', as: :status
    end
   end
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale
end
