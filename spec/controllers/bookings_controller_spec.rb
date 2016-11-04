require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  subject(:booking) { create :booking }

  describe '#new' do
    let(:flight) { create :flight }

    context 'when flight was selected' do
      before(:each) do
        get :new, params: { flight: flight.id,
                            passengers_count: 1,
                            departure: flight.departure }
      end

      it 'assigns that flight to a new booking' do
        expect(assigns(:booking).flight).to eq flight
      end

      it 'assigns departure to booking' do
        expect(assigns(:booking).departure).to eq flight.departure
      end

      it 'creates the passengers objects' do
        expect(assigns(:booking).passengers.size).to eq 1
      end

      it 'returns a status code of 200' do
        expect(response.status).to eq 200
      end

      it 'renders the new template' do
        expect(response).to render_template('new')
      end
    end

    context 'when flight was not selected' do
      before(:each) { get :new }

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets flash with error message' do
        expect(flash[:alert]).to eq 'No flight was selected.'
      end
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:flight) { create(:flight) }

    context 'when parameters are valid' do
      before(:each) do
        post :create, params: {
          booking: attributes_for(:booking,
                                  email: user.email,
                                  departure: flight.departure,
                                  flight_id: flight.id,
                                  user_id: user.id,
                                  passengers: attributes_for(:passenger))
        }
      end

      it 'creates new booking' do
        expect { subject }.to change(Booking, :count).by(1)
      end

      it 'sets the flash' do
        expect(flash[:alert]).to eq 'Your booking was successfully created.'
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to the show view' do
        expect(response).to redirect_to(assigns(:booking))
      end
    end

    context 'when parameters are invalid' do
      before(:each) do
        post :create, params: {
          booking: attributes_for(:booking,
                                  email: nil,
                                  flight_id: flight.id,
                                  passengers: attributes_for(:passenger))
        }
      end

      it 'does not create new booking' do
        expect(assigns[:booking].errors[:email]).to include "can't be blank"
      end

      it 'renders the new template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe '#edit' do
    before(:each) { get :edit, params: { id: booking.id } }

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

end
