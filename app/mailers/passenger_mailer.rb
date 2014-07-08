class PassengerMailer < ActionMailer::Base
	include FlightsHelper

  default from: "noreply@odinflightbooker.com"

  def thank_you_email(passenger)
  	booking         = passenger.bookings.last
  	@name           = passenger.name.strip
  	@flight_info    = flight_info(booking.flight)
  	@ref_number     = booking.ref_number
  	@url            = booking_url(booking)
  	email_with_name = "#{passenger.name} <#{passenger.email}>"
  	mail(to: email_with_name, subject: "Thank you for your flight booking")
  end

	def flight_info(flight)
		from = flight.from_airport
		to   = flight.to_airport
		"#{flight.flight_number} departing at #{flight_datetime(flight.id)} " \
		"from #{from.location} (#{from.code}) to #{to.location} (#{to.code})"
	end
end
