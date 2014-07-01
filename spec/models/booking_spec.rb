require 'spec_helper'

describe Booking do 
	let(:booking) { create(:booking) }
	subject { booking }

	it { should be_valid }
	it { should respond_to(:ref_number) }
	it { should respond_to(:flight) }
	it { should respond_to(:passenger_bookings) }
	it { should respond_to(:passengers) }

	describe "validations" do 
		it { should validate_presence_of(:ref_number) }
	end

	describe "associations" do
		it { should belong_to(:flight) }
		it { should have_many(:passenger_bookings).dependent(:destroy) }
		it { should have_many(:passengers) }
	end

	it { should accept_nested_attributes_for(:passengers) }
end
