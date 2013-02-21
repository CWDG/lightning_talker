LightningTalker::Application.routes.draw do
  resources :users


  resources :topics

  root :to => 'topics#index'
end
