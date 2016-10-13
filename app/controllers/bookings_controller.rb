class BookingsController < ApplicationController
  def new
    @flight_chosen = params[:flight]
    @booking = Booking.new
    params[:travelers].to_i.times { @booking.passengers.build }
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destory
  end

  private

  def booking_params

  end
end
