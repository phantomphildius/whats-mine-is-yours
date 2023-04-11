Rails.application.routes.draw do
  devise_for :users,
             path: "auth",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               confirmation: "verification",
               registration: "register",
               sign_up: "cmon_let_me_in"
             }

  resources :budgets, except: %i[index destroy] do
    resources :items,
              only: %i[create edit update destroy],
              controller: "budget_items" do
      resources :tags,
                only: %i[new create destroy],
                controller: "budget_item_tags"
    end
  end
  resources :statements, except: %i[destroy edit]
  # TODO: move under statements
  resources :statement_transaction_searches, only: :create
  resources :monthly_statements, only: :show do
    resources :transaction_categorizations,
              only: :create,
              controller: "transaction_categorizations"
    resources :charts, only: :show, controller: "monthly_statement_charts"
  end

  root to: "statements#index"
end
