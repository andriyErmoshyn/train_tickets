Rails.application.routes.draw do

  root 'routes#index'

  namespace :admin do
    resources :routes
    resources :tickets
  end

  resources :routes 
  resources :tickets
  
  resources :users, only: [ :new, :create, :show, :edit, :update ]
  resources :password_resets, only: [ :new, :create, :edit, :update ]

  get 'signup'    => 'users#new'
  get 'login'       => 'sessions#new'
  post 'login'      => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
