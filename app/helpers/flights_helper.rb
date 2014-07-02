module FlightsHelper

	def flight_name(id)
		Flight.find(id).flight_number
	end

	def from_location(id)
		airport = Flight.find(id).from_airport
		"#{airport.location} (#{airport.code})"
	end

	def to_location(id)
		airport = Flight.find(id).to_airport
		"#{airport.location} (#{airport.code})"
	end

	def flight_datetime(id)
		dt = Flight.find(id).start_time.utc
		"#{dt.strftime('%I:%M%p')} on #{dt.strftime('%a, %d %b')}"
	end

	def choose_flight_header(from_id, to_id, flight_date)
		"Flights from #{Airport.find(from_id).code} to " \
		"#{Airport.find(to_id).code} on #{flight_date}"
	end

	def flight_label(flight)
		"#{flight.start_time.strftime("%I:%M%p")} -- #{flight.flight_number}"
	end
end
