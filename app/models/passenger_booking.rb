class PassengerBooking < ActiveRecord::Base

	belongs_to :booking
	belongs_to :passenger

	validates :booking_id,   presence: true
	validates :passenger_id, presence: true

end
