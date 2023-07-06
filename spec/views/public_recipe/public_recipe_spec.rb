require 'rails_helper'
require 'devise'
RSpec.describe 'Pubic Recipe', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'Pubic recipe' do
    before(:each) do
      @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
      sign_in @user
      @recipe = Recipe.new(user_id: @user.id, name: 'My mama recipe', description: 'A good food!', preparation_time: 2,
                           cooking_time: 3, public: true)
      @recipe[:public] = true
      @recipe.save
      sign_out @user
      visit public_recipes_path
    end

    it 'should have the heading text' do
      expect(page).to have_content('Public Recipes')
    end

    it 'should render the name' do
      expect(page).to have_content(@recipe.name)
    end
  end
end
