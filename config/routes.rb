Rails.application.routes.draw do
  
  resources :showings
  resources :movies

  resources :tickets #, only:  [:index, :destroy, :show]

  resources :showings do
    resources :tickets #, only:  [:index, :new, :create]
  end

  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  devise_scope :user do 
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#home'
  # get 'sales_by_showing',  to: 'showings#sales_by_showing'

end
