require 'spec_helper'

describe Flight do
	let(:flight) { create(:flight) }
	subject { flight }

	it { should be_valid }
	it { should respond_to(:flight_number) }
	it { should respond_to(:start_time) }
	it { should respond_to(:duration) }
	it { should respond_to(:from_airport) }
	it { should respond_to(:to_airport) }

	describe "validations" do
		it { should validate_presence_of(:flight_number) }
		it { should validate_presence_of(:start_time) }
		it { should validate_presence_of(:duration) }
	end

	describe "associations" do
		it { should belong_to(:from_airport) }
		it { should belong_to(:to_airport) }
	end
end
