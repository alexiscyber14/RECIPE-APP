require 'rails_helper'
require 'devise'
RSpec.describe 'Food', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'index' do
    before(:each) do
      @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
      sign_in @user
      @food = Food.create(user_id: @user.id, name: 'Yeast', price: 3, measurement_unit: 'grams', quantity: '300')
      visit root_path
    end

    it 'renders name of food' do
      expect(page).to have_content(@food.name)
    end

    it 'renders the measurement_unit' do
      expect(page).to have_content(@food.measurement_unit)
    end

    it 'renders the quantity' do
      expect(page).to have_content(@food.quantity)
    end
  end
end
