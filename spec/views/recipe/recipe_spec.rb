require 'rails_helper'
require 'devise'
RSpec.describe 'Recipe', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'recipe' do
    before(:each) do
      @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
      sign_in @user
      @recipe = Recipe.create(user_id: @user.id, name: 'My mama recipe', description: 'A good food!',
                              preparation_time: '2', cooking_time: '3', public: false)
      visit recipes_path
      #   sign_out @user
    end

    it 'renders the recipe name' do
      expect(page).to have_content(@recipe.name)
    end

    it 'should not render the preparation_time' do
      expect(page).not_to have_content(@recipe.preparation_time)
    end

    it 'should not render the cooking time' do
      expect(page).not_to have_content(@recipe.cooking_time)
    end
  end
end
