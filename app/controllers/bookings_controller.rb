class BookingsController < ApplicationController
  def new
    @flight_id = params[:flight]
    @passengers = params[:passengers]
    if @flight_id
      @booking = Booking.new
      params[:passengers].to_i.times { @booking.passengers.build }
    else
      redirect_to root_path, alert: "No flight was selected."
    end
  end

  def create

  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def booking_params

  end
end
