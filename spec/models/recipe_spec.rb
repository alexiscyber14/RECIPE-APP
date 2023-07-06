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
      recipe = Recipe.new(user: @user, name: 'Pancakes', preparation_time: 30, cooking_time: 3,
                          description: 'Delicious pancakes')
      expect(recipe).to be_valid
    end

    it 'is not valid without a name' do
      recipe = Recipe.new(preparation_time: 30, cooking_time: 33, description: 'Delicious pancakes')
      expect(recipe).not_to be_valid
      expect(recipe.errors[:name]).to include("can't be blank")
    end
  end
end
