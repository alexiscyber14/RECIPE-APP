require 'rails_helper'
require 'devise'
RSpec.describe 'Food', type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
    sign_in @user
  end

  describe 'GET /index' do
    it 'renders name of food' do
      get root_path
      expect(response).to be_successful
    end

    it 'renders the template accurately' do
      get root_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_food_path
      expect(response).to be_successful
    end

    it 'renders the template accurately' do
      get new_food_path
      expect(response).to render_template('new')
    end
  end

  describe 'POST /foods' do
    it 'creates a new food' do
      post foods_path, params: { food: { name: 'Yeast', measurement_unit: 'grams', price: 3, quantity: '300' } }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes an existing food' do
      food = Food.create(name: 'Yeast', measurement_unit: 'grams', price: 4, quantity: '300', user_id: @user.id)

      expect do
        delete "/foods/#{food.id}"
      end.to change(Food, :count).by(-1)

      expect(response).to redirect_to(root_path)
    end
  end
end
