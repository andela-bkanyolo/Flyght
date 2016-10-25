require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    before(:each) {  get :new }
    it 'returns a status response of 200' do
      expect(response.status).to eq 200
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end
end
