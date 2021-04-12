Rails.application.routes.draw do
  root to: 'power_generators#index'
  resources :home, only: %i[index]

  resources :power_generators, only: %i[show] do
    get 'get_freight', on: :member, defaults: { format: :json }
  end

  get 'search', to: 'power_generators#search'
end
