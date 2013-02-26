LightningTalker::Application.routes.draw do
  resources :users

  resources :topics do
    put 'claim' => 'topics#claim', on: :member
    put 'unclaim' => 'topics#unclaim', on: :member
    get 'schedule' => 'topics#schedule', on: :collection
  end

  resources :sessions, only: [:new, :create]

  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'sign_in' => 'sessions#new', as: 'sign_in'
  get 'sign_out' => 'sessions#destroy', as: 'sign_out'

  root :to => 'topics#index'
end
