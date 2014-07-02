require 'spec_helper'

describe "Flight pages" do
	subject { page }

	describe "index" do
		before do
			from_airport = create(:airport_with_flights)
			to_airport   = create(:to_airport)
			visit flights_path
		end

    it { should have_title('Odin Flight Booker') }
    it { should have_text('Search For Flights') }
		it { should have_select('From',  with_options: ['SFO', 'NYC']) }
		it { should have_select('To',    with_options: ['SFO', 'NYC']) }
		it { should have_select('Passengers', options: ['1', '2', '3', '4']) }
		it { should have_select('Flight date') }
		it { should have_button('Search Flights') }

		describe "after flight search" do
			before do
				fill_search_form
				click_on('Search Flights')
			end

			it "remains on index page" do
				expect(current_path).to eq(flights_path)
			end

			it "has flight results" do
				expect(page).to have_selector("input[type=radio]")
			end

			it { should have_submit('Choose Flight') }

			describe "and flight choice" do 
				it "should go to new booking" do
					click_on('Choose Flight')
					expect(current_path).to eq(new_booking_path)
				end
			end
		end

		describe "with no search results" do
			before do
				extra_airport = create(:airport, code: 'ATL')
				fill_search_form
				select('ATL', from: 'From')
				click_on('Search Flights')
			end

			it { should have_selector("h3", text: "No Flights found") }
		end

		describe "invalid search" do
			before do
				fill_search_form
				select('SFO', from: 'To', match: :first)
				click_on('Search Flights')
			end

			it "displays error message" do
				expect(page).to have_css(".alert.alert-error")
			end
		end

	end
end
