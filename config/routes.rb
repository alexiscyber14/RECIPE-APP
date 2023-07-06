# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :food_recipes
  resources :recipe_foods
  devise_for :users
  root 'foods#index'
  get 'recipe_foods/create'
  get 'recipe_foods/edit'
  get 'recipe_foods/destroy'
  resources :recipes
  resources :public_recipes
  resources :users
  resources :foods, except: [:update]
  get 'recipes/:id/food_recipes/new', to: 'food_recipes#new', as: 'new_food_recipe'
  post 'recipes/:id/food_recipes/', to: 'food_recipes#create', as: 'food_recipes'
  get 'general_shopping_list', to: 'food_recipes#index', as: 'general_shopping_list'
  put 'recipes/:id/toggle_button', to: 'recipes#toggle_action', as: 'toggle_action'
  # get 'recipes#show', to: 'recipe_foods/index', as: 'recipie_foods'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
