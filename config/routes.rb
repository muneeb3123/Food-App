Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  resources :foods do
    resources :recipe_foods
  end
  
  resources :recipes, only: [:index, :show, :create, :new, :destroy] do
    member do
      patch :toggle_public
    end
    resources :recipe_foods
  end
end
