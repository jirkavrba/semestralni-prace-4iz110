Rails.application.routes.draw do
  resources :domains, except: [:show] do
    get '/index', to: 'domains#start_indexing', on: :member
  end

  root to: 'search#index'
  get '/search', to: 'search#results'
end
