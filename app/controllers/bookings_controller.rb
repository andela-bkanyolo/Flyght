class BookingsController < ApplicationController
  def new
    flight = Flight.find_by id: params[:flight]
    if flight
      @booking = flight.bookings.new
      params[:passengers].to_i.times { @booking.passengers.build }
    else
      redirect_to root_path, alert: "No flight was selected."
    end
  end

  def create
    flight = Flight.find_by id: booking_params[:flight_id]
    @booking = flight.bookings.new(booking_params)
    if @booking.save
      BookingMailer.booking_confirmation(@booking).deliver_later
      redirect_to @booking
    else
      params[:passengers] = booking_params[:passengers_attributes].length
      params[:departure] = booking_params[:departure]
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      BookingMailer.booking_confirmation(@Booking).deliver_later
      redirect_to @booking
    else
      params[:passengers] = booking_params[:passengers_attributes].length
      params[:departure] = booking_params[:departure]
      render 'edit'
    end
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
        redirect_to manage_bookings_path, alert: "Booking #{ref} does not exist"
      end
    end
  end

  private

  def booking_params
    params.require(:booking)
          .permit(:email, :departure, :flight_id, :user_id,
          passengers_attributes: [:id, :name, :age, :passport, :phone, :_destroy])
  end
end
