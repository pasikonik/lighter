Rails.application.routes.draw do

  devise_for :users, skip: [:session, :password, :registration], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  scope "(:locale)", locale: /en|pl/ do
    devise_for :users, skip: [:omniauth_callbacks]
    ActiveAdmin.routes(self)
    get 'search' => 'videos#index', as: :search

    root 'home#index'

    get 'set_language/en', as: :en
    get 'set_language/pl', as: :pl

    scope '/lighter' do
      get '/construction' => 'lighter#construction', as: :construction
      get '/types' => 'lighter#types', as: :types
      get '/history' => 'lighter#history', as: :history
    end

    resources :tutorials
    resources :entries
    resources :images
    resources :comments

    resources :videos do
      member do
        post :vote
        post :add_comment
        get :tags
      end
    end
  end
end
