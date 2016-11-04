require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  subject(:booking) { create(:booking) }

  describe '#new' do
    let(:flight) { create(:flight) }

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

  describe '#show' do
    before(:each) { get :show, params: { id: booking.id } }

    it 'assigns a booking object' do
      expect(assigns(:booking)).to eq booking
    end

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe '#edit' do
    before(:each) do
      stub_current_user(booking.user)
      get :edit, params: { id: booking.id }
    end

    it 'assigns a booking object' do
      expect(assigns(:booking)).to eq booking
    end

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe '#update' do
    let(:departure) { booking.departure + 1.day }

    context 'when parameters are valid' do
      before(:each) do
        stub_current_user(booking.user)
        patch :update, params: {
          id: booking.id,
          booking: attributes_for(:booking,
                                  email: booking.email,
                                  departure: booking.departure,
                                  flight_id: booking.flight.id,
                                  user_id: booking.user_id,
                                  passengers: attributes_for(:passenger))
        }
      end

      it 'sets the flash' do
        expect(flash[:alert]).to eq 'Your booking was successfully updated.'
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
        stub_current_user(booking.user)
        patch :update, params: {
          id: booking.id,
          booking: attributes_for(:booking,
                                  email: booking.email,
                                  departure: nil,
                                  flight_id: booking.flight.id,
                                  user_id: booking.user_id,
                                  passengers: attributes_for(:passenger))
        }
      end

      it 'does not update the booking' do
        expect(assigns[:booking].errors[:departure]).to include "can't be blank"
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    let(:user) { booking.user }
    before(:each) do
      stub_current_user(user)
      delete :destroy, params: { id: booking.id }
    end

    it 'deletes the booking' do
      expect(Booking.find_by(id: booking.id)).to eq nil
    end

    it 'returns a status code of 200' do
      expect(response.status).to eq 302
    end

    it 'sets the flash' do
      expect(flash[:alert]).to eq 'Your booking was successfully deleted!'
    end

    it 'redirects to bookings user path' do
      expect(response).to redirect_to bookings_user_path(user)
    end
  end

  describe '#manage' do
    before(:each) do
      get :manage, params: { ref: booking.reference }
    end

    it 'assigns a booking object' do
      expect(assigns(:booking)).to eq booking
    end

    it 'returns a status code of 302' do
      expect(response.status).to eq 302
    end

    it 'sets the flash' do
      expect(flash[:alert]).to eq 'Booking found.'
    end

    context 'when user is anonymous' do
      it 'redirects to show booking path' do
        expect(response).to redirect_to(assigns(:booking))
      end
    end

    context 'when user is logged in' do
      let(:user_booking) { create(:booking, email: booking.user.email) }

      before(:each) do
        stub_current_user(booking.user)
        get :manage, params: { ref: user_booking.reference }
      end

      it 'redirects to edit booking path' do
        expect(response).to redirect_to edit_booking_path(user_booking)
      end
    end

    context 'with invalid booking reference' do
      before(:each) do
        get :manage, params: { ref: Faker::Code.asin }
      end

      it 'redirects to edit booking path' do
        expect(response).to redirect_to find_bookings_path
      end

      it 'sets the flash' do
        expect(flash[:alert]).to eq 'Booking was not found.'
      end
    end
  end
end
