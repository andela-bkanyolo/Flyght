class BookingsController < ApplicationController
  before_action :find_booking_by_code, only: [:manage]
  before_action :find_booking_by_id, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:edit, :update, :destroy]

  def new
    flight = Flight.find_by(id: params[:flight])
    if flight
      @booking = flight.bookings.new
      @booking.departure = params[:departure]
      params[:passengers_count].to_i.times { @booking.passengers.build }
    else
      redirect_to root_path, alert: no_flight_selected
    end
  end

  def create
    flight = Flight.find_by(id: booking_params[:flight_id])
    @booking = flight.bookings.new(booking_params)
    if @booking.save
      BookingMailer.booking_confirmation(@booking).deliver_later
      redirect_to @booking, alert: booking_saved
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      BookingMailer.booking_confirmation(@booking).deliver_later
      redirect_to @booking, alert: booking_updated
    else
      render 'edit'
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_user_path(current_user), alert: booking_deleted
  end

  def manage
    if can_edit(@booking)
      redirect_to edit_booking_path(@booking), alert: booking_found
    else
      redirect_to @booking, alert: booking_found
    end
  end

  private

  def find_booking_by_id
    @booking = Booking.find(params[:id])
  end

  def find_booking_by_code
    @booking = Booking.find_by(reference: params[:ref].strip)
    @booking || record_not_found
  end

  def record_not_found
    redirect_to find_bookings_path, alert: booking_not_found
  end

  def can_edit(booking)
    current_user && current_user.email == booking.email
  end

  def booking_params
    params.require(:booking)
          .permit(:email, :departure, :flight_id, :user_id,
                  passengers_attributes: [:id, :name, :age, :passport, :phone])
  end
end
