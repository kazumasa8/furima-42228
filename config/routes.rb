Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  root "items#index" 

  resources :items do
    resources :orders, only: [:index, :create]
  end

end
