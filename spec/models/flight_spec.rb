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

	describe ".all_unique_future_flight_dates" do
		let!(:future_flight) { create(:flight) }

		it "selects only future flights" do
			past_flight = create(:flight, start_time: 1.day.ago)
			expect(Flight.count).to eq(2)
			expect(Flight.all_unique_future_flight_dates.count).to eq(1)
		end

		it "selects only unique flight dates" do
			same_day_flight = create(:flight)
			expect(Flight.count).to eq(2)
			expect(Flight.all_unique_future_flight_dates.count).to eq(1)
		end
	end
end
