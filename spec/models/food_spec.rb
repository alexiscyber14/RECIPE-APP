require 'rails_helper'

RSpec.describe Food, type: :model do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
    sign_in @user
    subject { Food.create(name: 'pizza', measurement_unit: 'grams', price: 2.5, quantity: 4, user: @user) }
  end

  describe 'Validations' do
    describe 'validations' do
      it 'is valid with valid attributes' do
        food = Food.new(
          name: 'Yeast',
          measurement_unit: 'grams',
          price: 2.99,
          quantity: 300,
          user_id: @user.id
        )
        expect(food).to be_valid
      end

      it 'is not valid without a name' do
        food = Food.new(
          measurement_unit: 'grams',
          price: 2.99,
          quantity: 300,
          user_id: @user.id
        )
        expect(food).not_to be_valid
        expect(food.errors[:name]).to include("can't be blank")
      end

      it 'is not valid without a measurement_unit' do
        food = Food.new(
          name: 'Yeast',
          price: 2.99,
          quantity: 300,
          user_id: @user.id
        )
        expect(food).not_to be_valid
        expect(food.errors[:measurement_unit]).to include("can't be blank")
      end

      it 'is not valid if price is not a number' do
        food = Food.new(
          name: 'Yeast',
          measurement_unit: 'grams',
          price: 'invalid_price',
          quantity: 300,
          user_id: @user.id
        )
        expect(food).not_to be_valid
        expect(food.errors[:price]).to include('is not a number')
      end

      it 'is not valid if quantity is not an integer' do
        food = Food.new(
          name: 'Yeast',
          measurement_unit: 'grams',
          price: 2.99,
          quantity: 'invalid_quantity',
          user_id: @user.id
        )
        expect(food).not_to be_valid
        expect(food.errors[:quantity]).to include('is not a number')
      end
    end
  end
end
