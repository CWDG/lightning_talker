LightningTalker::Application.routes.draw do
  resources :users
  resources :topics
  resources :sessions, only: [:new, :create]

  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'sign_in' => 'sessions#new', as: 'sign_in'
  get 'sign_out' => 'sessions#destroy', as: 'sign_out'

  root :to => 'topics#index'
end
