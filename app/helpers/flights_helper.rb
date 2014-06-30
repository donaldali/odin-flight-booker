module FlightsHelper

	def choose_flight_header(from_id, to_id, flight_date)
		"Flights from #{Airport.find(from_id).code} to " \
		"#{Airport.find(to_id).code} on #{flight_date}"
	end

	def flight_label(flight)
		"#{flight.start_time.strftime("%I:%M%p")} -- #{flight.flight_number}"
	end
end
