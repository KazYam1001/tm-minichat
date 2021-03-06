Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :groups, only: [:index, :create, :show, :update, :destroy] do
      resources :messages, only: [:index, :create]
    end
  end
end
