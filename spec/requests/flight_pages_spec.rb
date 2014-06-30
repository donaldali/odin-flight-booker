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
		it { should have_submit('Search Flights') }

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
		end

		describe "invalid search" do
			before do
				fill_search_form
				select('SFO', from: 'To', match: :first)
				click_on('Search Flights')
			end

			it "displays error message" do
				expect(page).to have_css(".alert.alert-warning")
			end
		end

	end
end
