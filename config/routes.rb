Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  root to: "rails_admin/main#dashboard"

  devise_for :users

  get 'reports', to: "reports#index"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
