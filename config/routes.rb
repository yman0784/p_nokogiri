Rails.application.routes.draw do
  root to: 'tests#index'
  resources :tests do
    collection do
      get 'search'
    end
  end
  resources :searches
end
