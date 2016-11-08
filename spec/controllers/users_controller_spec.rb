require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before(:each) { get :new }

    it 'assigns new user object' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user_email) { Faker::Internet.email }
    context 'with valid params' do
      let(:user_create_request) do
        post :create, params: {
          user: attributes_for(
            :user,
            first_name: 'B',
            last_name: 'K',
            email: user_email
          )
        }
      end

      it 'increments users count by 1' do
        expect { user_create_request }.to change(User, :count).by(1)
      end

      it 'returns a status code of 302' do
        user_create_request
        expect(response.status).to eq 302
      end

      it 'sets the session accordingly' do
        user_create_request
        new_user = User.find_by(email: user_email)
        expect(session[:user_id]).to eq new_user.id
      end

      it 'redirects to root_path' do
        user_create_request
        expect(response).to redirect_to root_path
      end

      it 'sets flash with welcome message' do
        user_create_request
        expect(flash[:notice]).to eq 'Welcome B K'
      end
    end

    context 'with invalid params' do
      before(:each) do
        post :create, params: {
          user: attributes_for(:user, email: nil)
        }
      end

      it 'does not create new user' do
        expect(assigns[:user].errors[:email]).to include "can't be blank"
      end

      it 'renders the new template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe '#bookings' do
    let(:user) { create(:user) }

    before(:each) do
      stub_current_user(user)
      get :bookings, params: { id: user.id }
    end

    it 'assigns bookings object' do
      expect(assigns(:bookings)).to eq user.bookings
    end

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'renders the bookings template' do
      expect(response).to render_template('bookings')
    end
  end
end
