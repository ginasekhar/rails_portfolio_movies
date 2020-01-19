Rails.application.routes.draw do
  
  resources :movies

  resources :movies, only: [:show] do
    #resources :showings, only: [:show, :index, :destroy]
    resources :showings, only: [:show]
  end

  resources :tickets , only:  [:index, :destroy, :show]

  resources :showings , only: [:show, :index, :destroy] do
    resources :tickets , only:  [:index, :new, :create]
  end

  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  devise_scope :user do 
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#home'
  

end
