class BookingMailer < ApplicationMailer
  default from: "bookings@flyghts.com"

  def booking_confirmation(booking)
    @booking = booking
    mail(to: @booking.email, subject: 'Your Flyght Itinerary')
  end
end
