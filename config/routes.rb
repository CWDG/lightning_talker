LightningTalker::Application.routes.draw do
  resources :topics

  root :to => 'topics#index'
end
