class Airport < ActiveRecord::Base

	has_many :departing_flights, class_name:  "Flight", dependent: :destroy,
	                             foreign_key: "from_airport_id"
	has_many :arriving_flights,  class_name:  "Flight", dependent: :destroy,
	                             foreign_key: "to_airport_id"

  validates :code,     presence: true, length: {is: 3}
	validates :location, presence: true
	
end
