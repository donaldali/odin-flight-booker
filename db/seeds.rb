# Seed the airports and flights tables

Airport.delete_all
Flight.delete_all

def airports_data
	[ ["ATL", "Atlanta, GA"],           ["ORD", "Chicago, IL"],
	  ["JFK", "New York, NY"],          ["SFO", "San Francisco, CA"],
	  ["LAX", "Los Angeles, CA"],       ["MIA", "Miami, FL"],
	  ["DFW", "Dallas/Fort Worth, TX"], ["DEN", "Denver, CO"],
	  ["CLT", "Charlotte, NC"],         ["LAS", "Las Vegas, NV"] ]
end

def create_airports(airports_to_create)
	airports_to_create.each do |airport|
		Airport.create!({code: airport[0], location: airport[1]})
	end
end

def random_flight
	airlines = ["American Airlines", "Delta Air Lines", "Southwest Airlines",
	            "United Airlines",   "US Airways"]
	"#{airlines.sample} #{rand(1900) + 100}"
end

def random_duration
	(rand(240) + 120).minutes
end

def random_start(days_from_now)
	days_from_now.days.from_now.midnight + (60 * (rand(60 * 24)))
end

def create_flights(number_of_days, daily_flights)
	airports = Airport.all

	airports.each do |from_airport|
		airports.each do |to_airport|
			next if from_airport == to_airport
			duration = random_duration
			(1..number_of_days).each do |days_from_now|
				number_of_flights = daily_flights + (rand(7) - 3)
				number_of_flights.times do 
					Flight.create!({ flight_number:   random_flight,
						               start_time:      random_start(days_from_now),
			                     duration:        duration,
			                     from_airport_id: from_airport.id,
			                     to_airport_id:   to_airport.id })
	      end
	    end
		end
	end
end

def create_data
	avg_daily_flights = 7
	number_of_days    = 7
	airports_limit    = 5

	airports_to_create = airports_data[0..airports_limit - 1]
	create_airports(airports_to_create)
	create_flights(number_of_days, avg_daily_flights)
end

create_data
