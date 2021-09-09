Rails.application.routes.draw do
  root to: "rails_admin/main#dashboard"

  devise_for :users

  get 'reports', to: "reports#index"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
