Rails.application.routes.draw do
  resources :domains

  root to: 'search#index'
end
