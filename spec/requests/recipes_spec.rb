require 'rails_helper'
require 'devise'
RSpec.describe 'Recipe', type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
    sign_in @user
  end

  describe 'GET /index' do
    it 'assert the response of the index' do
      get recipes_path
      expect(response).to be_successful
    end

    it 'renders the template accurately' do
      get recipes_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_recipe_path
      expect(response).to be_successful
    end

    it 'renders the template accurately' do
      get new_recipe_path
      expect(response).to render_template('new')
    end
  end

  describe 'POST /create' do
    it 'creates a new recipe' do
      post recipes_path,
           params: { recipe: { name: "My mama's recipe", description: 'Food!', preparation_time: 1, cooking_time: 2,
                               public: false } }
      expect(response).to redirect_to(recipes_path)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes an existing recipe' do
      recipe = Recipe.create(name: "My mama's recipe", description: 'Good recipe!', preparation_time: 1,
                             cooking_time: 2, public: false, user_id: @user.id)

      expect do
        delete "/recipes/#{recipe.id}"
      end.to change(Recipe, :count).by(-1)

      expect(response).to redirect_to(recipes_path)
    end
  end
end
