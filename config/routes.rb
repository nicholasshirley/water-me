Rails.application.routes.draw do
  devise_for :users
  get root to: 'pages#index'

  resources :log_entries
end
