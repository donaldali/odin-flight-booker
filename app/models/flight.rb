class Flight < ActiveRecord::Base
	validates :flight_number, presence: true
	validates :start_time,    presence: true
	validates :duration,      presence: true

	belongs_to :from_airport, class_name: "Airport"
	belongs_to :to_airport,   class_name: "Airport"
end
