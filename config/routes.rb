Rails.application.routes.draw do
  resources :recipe_foods
  devise_for :users
  root 'foods#index'
  get 'recipe_foods/create'
  get 'recipe_foods/edit'
  get 'recipe_foods/destroy'
  resources :recipes do
    get 'generate_shopping_list', on: :member
  end
  resources :public_recipes
  resources :users
  resources :foods
  #get 'recipes/:id/food_recipes/new', to: 'food_recipes#new', as: 'new_food_recipe'
  #post 'recipes/:id/food_recipes/', to: 'food_recipes#create', as: 'food_recipes'
  #get 'general_shopping_list', to: 'food_recipes#index', as: 'general_shopping_list'
  #put 'recipes/:id/toggle_button', to: 'recipes#toggle_action', as: 'toggle_action'
end
