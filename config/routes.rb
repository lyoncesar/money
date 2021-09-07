Rails.application.routes.draw do
  devise_for :users

  #root to: "home#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
