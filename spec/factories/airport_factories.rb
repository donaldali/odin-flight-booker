FactoryGirl.define do
	factory :airport, aliases: [:from_airport] do
		code     "SFO"
		location "San Francisco, CA"

		factory :airport_with_flights do
			ignore { flight_count 3 }

			after(:create) do |airport, evaluator|
				create_list(:flight, evaluator.flight_count, from_airport: airport)
				create_list(:flight, evaluator.flight_count, to_airport:   airport)
			end
		end
	end

	factory :to_airport, class: Airport do
		code     "NYC"
		location "New York, NY"
	end
end
