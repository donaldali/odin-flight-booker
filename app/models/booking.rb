class Booking < ActiveRecord::Base

	before_validation :set_ref_number, on: :create

	belongs_to :flight
	has_many   :passenger_bookings, dependent: :destroy
	has_many   :passengers, through: :passenger_bookings

	validates :ref_number, presence: true

	accepts_nested_attributes_for :passengers

	private

	  def set_ref_number
	  	ref = ""
	  	3.times { ref += ('A'..'Z').to_a.sample }
	  	4.times { ref += ('0'..'9').to_a.sample }
	  	self.ref_number = ref
	  end
	
end
