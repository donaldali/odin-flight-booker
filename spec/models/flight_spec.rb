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
		it "should require flight_number" do
			bad_flight = build(:flight, flight_number: "")
			expect(bad_flight).not_to be_valid
		end

		it "should require start_time" do
			bad_flight = build(:flight, start_time: nil)
			expect(bad_flight).not_to be_valid
		end

		it "should require duration" do
			bad_flight = build(:flight, duration: nil)
			expect(bad_flight).not_to be_valid
		end
	end

	describe "associations" do
		it "belongs to a from airport" do
			expect(Flight.reflect_on_association(:from_airport).macro).to eq(:belongs_to)
		end

		it "links to from airport" do
			airport = create(:airport, code: "ATL")
			flight.from_airport = airport
			expect(flight.from_airport).to eq(airport)
		end

		it "belongs to a to airport" do
			expect(Flight.reflect_on_association(:to_airport).macro).to eq(:belongs_to)
		end

		it "links to to airport" do
			airport = create(:airport, code: "ATL")
			flight.to_airport = airport
			expect(flight.to_airport).to eq(airport)
		end
	end
end
