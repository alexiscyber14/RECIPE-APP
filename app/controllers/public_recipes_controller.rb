class PublicRecipesController < ApplicationController
  load_and_authorize_resource
  def index
    @recipes = Recipe.includes(user: :foods).where(public: true)
  end
end
