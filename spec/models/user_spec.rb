require 'rails_helper'

RSpec.describe Food, type: :model do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
    sign_in @user
    subject { Food.create(name: 'pizza', measurement_unit: 'grams', price: 2.5, quantity: 4, user: @chef) }
  end

  it 'is not valid without a name' do
    user = User.new(email: 'john@example.com')
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end
end

describe 'associations' do
  it 'has many foods' do
    @user = User.reflect_on_association(:foods)
    expect(@user.macro).to eq(:has_many)
  end

  it 'has many recipes' do
    @user = User.reflect_on_association(:recipes)
    expect(@user.macro).to eq(:has_many)
  end
end
