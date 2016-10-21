class BookingMailer < ApplicationMailer
  default from: "bookings@flyghtrails.heroku.com"

  def booking_confirmation(booking)
    @booking = booking
    mail(to: @booking.email, subject: 'Your Flyght Itinerary')
  end
end
