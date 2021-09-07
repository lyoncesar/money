Rails.application.routes.draw do
  devise_for :users

  root to: "rails_admin/main#dashboard"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
