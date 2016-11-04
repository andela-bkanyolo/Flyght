require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject(:user) { create(:user) }

  describe 'GET #new' do
    before(:each) { get :new }
    it 'returns a status response of 200' do
      expect(response.status).to eq 200
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    before(:each) do
      post :create, params: {
        session: { email: user.email, password: user.password }
      }
    end

    it 'returns a status code of 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end

    context 'when parameters are valid' do
      before(:each) do
        post :create, params: {
          session: { email: user.email, password: user.password }
        }
      end

      it 'sets session id to the user id' do
        expect(session[:user_id]).to eq user.id
      end

      it 'sets the flash accordingly' do
        expect(flash[:notice]).to eq "Welcome back, #{user.full_name}"
      end
    end

    context 'when parameters are invalid' do
      before(:each) do
        post :create, params: {
          session: { email: Faker::Internet.email, password: user.password }
        }
      end

      it 'sets the flash accordingly' do
        expect(flash[:alert]).to eq 'Incorrect email or password.'
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      stub_current_user(user)
      delete :destroy
    end

    it 'deletes the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'returns a status code of 302' do
      expect(response.status).to eq 302
    end

    it 'sets the flash' do
      expect(flash[:notice]).to eq "GoodBye, #{user.full_name}"
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end
end
