require 'spec_helper'

describe PassengerBooking do
	let(:passenger_booking) { create(:passenger_booking) }
	subject { passenger_booking }

	it { should be_valid }
	it { should respond_to(:booking_id) }
	it { should respond_to(:passenger_id) }

	describe "associations" do 
		it { should belong_to(:booking) }
		it { should belong_to(:passenger) }
	end

	describe "validations" do
		it { should validate_presence_of(:booking_id) }
		it { should validate_presence_of(:passenger_id) }
	end

end
