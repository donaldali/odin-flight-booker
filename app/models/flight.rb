class Flight < ActiveRecord::Base
	validates :flight_number, presence: true
	validates :start_time,    presence: true
	validates :duration,      presence: true

	belongs_to :from_airport, class_name: "Airport"
	belongs_to :to_airport,   class_name: "Airport"

	def self.all_unique_future_flight_dates
		Flight.where("start_time > :future", {future: Time.now.utc.tomorrow.midnight}).
		       select(:start_time).order(start_time: :asc).
		       map{|f| f.start_time.utc.strftime('%d/%m/%Y')}.uniq
	end

	def self.search_flights(from_id, to_id, flight_date)
    flight_date = Date.strptime(flight_date, "%d/%m/%Y")
    Flight.where(from_airport_id: from_id).where(to_airport_id: to_id).
           where("start_time >= :start AND start_time < :stop", 
           	     {start: flight_date.midnight, stop: flight_date.tomorrow.midnight}).
           order(:start_time)
	end
end
