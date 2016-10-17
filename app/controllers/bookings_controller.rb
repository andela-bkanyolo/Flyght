class BookingsController < ApplicationController
  def new
    flight_id = params[:flight]
    @passengers = params[:passengers]
    if flight_id
      @flight =  Flight.find_by id: flight_id
      @reference = generate_reference(flight_id)
      @booking = Booking.new
      @total = (@flight.price * @passengers.to_i).round(2)
      params[:passengers].to_i.times { @booking.passengers.build }
    else
      redirect_to root_path, alert: "No flight was selected."
    end
  end

  def create
    @flight = Flight.find_by id: booking_params[:flight_id]
    @booking = Booking.new(booking_params)
    if @booking.save
      BookingMailer.booking_confirmation(@booking).deliver_later
      redirect_to @booking
    else
      @total = booking_params[:price]
      @reference = booking_params[:reference]
      @passengers = booking_params[:passengers_attributes].length
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

  def manage
    ref = params[:ref]
    if ref
      @booking = Booking.find_by reference: ref
      if @booking
        redirect_to booking_path(@booking)
      else
        redirect_to manage_path, alert: "Booking #{ref} does not exist"
      end
    end
  end

  private

  def booking_params
    params.require(:booking)
      .permit(:reference, :email, :price, :flight_id, passengers_attributes: [:name, :age, :passport, :phone])
  end

  def generate_reference(flight_id)
    flight = Flight.find_by id: flight_id
    "#{SecureRandom.hex(3)}/#{flight.id}/#{flight.ref}".upcase
  end
end
