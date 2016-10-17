class BookingsController < ApplicationController
  def new
    flight_id = params[:flight]
    @passengers = params[:passengers]
    if flight_id
      @flight =  Flight.find_by id: flight_id
      @reference = generate_reference(flight_id)
      @booking = Booking.new
      params[:passengers].to_i.times { @booking.passengers.build }
    else
      redirect_to root_path, alert: "No flight was selected."
    end
  end

  def create
    @flight = Flight.find_by id: booking_params[:flight_id]
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking
    else
      @reference = booking_params[:reference]
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking)
      .permit(:reference, :email, :flight_id, passengers_attributes: [:name, :age, :passport, :phone])
  end

  def generate_reference(flight_id)
    flight = Flight.find_by id: flight_id
    "#{SecureRandom.hex(3)}/#{flight.id}/#{flight.ref}".upcase
  end
end
