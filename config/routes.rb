Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', confirmation: 'verification', registration: 'register', sign_up: 'cmon_let_me_in' }

  resources :budgets, except: %i(index destroy) do
    resources :items, only: %i(create edit destroy), controller: 'budget_items'
  end
  resources :statements, except: %i(destroy edit)

  root to: 'statements#index'
end
