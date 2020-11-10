Rails.application.routes.draw do
  resources :domains do
    get '/index', to: 'domains#start_indexing', on: :member
  end

  root to: 'search#index'
end
