require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
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
end
