require 'spec_helper'

describe Airport do
	let(:airport) { create(:airport) }
	subject { airport }

	it { should respond_to(:code) }
	it { should respond_to(:location) }
	it { should respond_to(:departing_flights) }
	it { should respond_to(:arriving_flights) }

	describe "validations" do
		it { should be_valid }

		it "requires code" do
			bad_airport = build(:airport, code: "")
			expect(bad_airport).not_to be_valid
		end

		it "rejects codes with wrong length" do
			other_airport = build(:airport, code: "SFOX")
			expect(other_airport).not_to be_valid
		end

		it "requires location" do
			bad_airport = build(:airport, location: "")
			expect(bad_airport).not_to be_valid
		end
	end

	describe "association" do
		it "has many departing flights" do
			expect(Airport.reflect_on_association(:departing_flights).macro).to eq(:has_many)
		end

		it "links departing flights" do
			flight = create(:flight)
			airport.departing_flights << flight
			expect(airport.departing_flights).to include(flight)
		end

		it "has many arriving flights" do
			expect(Airport.reflect_on_association(:arriving_flights).macro).to eq(:has_many)
		end

		it "links arriving flights" do
			flight = create(:flight)
			airport.arriving_flights << flight
			expect(airport.arriving_flights).to include(flight)
		end

		describe "dependent destruction" do 
			let(:used_airport) { create(:airport_with_flights) }

			specify "for departing flights" do
				departing = used_airport.departing_flights.to_a
				used_airport.destroy
				expect(departing).not_to be_empty
				departing.each do |a_flight|
					expect(Flight.where(id: a_flight.id)).to be_empty
				end
			end

			specify "for arriving flights" do
				arriving = used_airport.arriving_flights.to_a
				used_airport.destroy
				expect(arriving).not_to be_empty
				arriving.each do |a_flight|
					expect(Flight.where(id: a_flight.id)).to be_empty
				end
			end
		end
	end
end
