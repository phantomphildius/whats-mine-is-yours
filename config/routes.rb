Rails.application.routes.draw do
  root to: 'statements#index'

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', confirmation: 'verification', registration: 'register', sign_up: 'cmon_let_me_in' }

  resources :statements
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

end
