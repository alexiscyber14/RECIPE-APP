require 'rails_helper'

RSpec.describe Food, type: :model do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
    sign_in @user
    subject { Food.create(name: 'pizza', measurement_unit: 'grams', price: 2.5, quantity: 4, user: @chef) }
  end
  describe 'validations' do
    it 'is valid with valid attributes' do
      recipe = Recipe.create(user_id: @user.id, name: 'My mama recipe', description: 'A good food!',
                             preparation_time: '2', cooking_time: '3', public: false)
      food = Food.create(name: 'pizza', measurement_unit: 'grams', price: 2.5, quantity: 4, user: @user)
      food_recipe = FoodRecipe.new(quantity: 5, food_id: food.id, recipe_id: recipe.id)
      expect(food_recipe).to be_valid
    end

    it 'is not valid without a quantity' do
      @food_recipe = FoodRecipe.new
      expect(@food_recipe).not_to be_valid
      expect(@food_recipe.errors[:quantity]).to eq([])
    end
  end
end
