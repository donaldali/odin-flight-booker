class Booking < ActiveRecord::Base

	belongs_to :flight
	has_many   :passenger_bookings, dependent: :destroy
	has_many   :passengers, through: :passenger_bookings

	validates :ref_number, presence: true

	accepts_nested_attributes_for :passengers
	
end
