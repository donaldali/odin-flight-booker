FactoryGirl.define do
	factory :flight do
		sequence(:flight_number) { |n| "Delta #{n}" }
		start_time 1.day.from_now
		duration   250
		from_airport
		to_airport
	end
end
