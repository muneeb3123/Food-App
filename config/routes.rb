Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :foods do
    resources :recipe_foods
  end
  resources :recipes do
    resources :recipe_foods
  end
end
