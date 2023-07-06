require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'Caleb Nwaizu', email: 'calebchris000@gmail.com', password: 111_111)
    sign_in @user
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get general_shopping_list_path
      expect(response).to be_successful
    end

    it 'renders the accurate template' do
      get general_shopping_list_path
      expect(response).to render_template(:index)
    end
  end
end
