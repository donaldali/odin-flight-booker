require 'spec_helper'

describe "Booking Pages" do
	subject { page }

	before do
		from_airport = create(:airport_with_flights)
		to_airport   = create(:to_airport)
		visit flights_path
		fill_search_form
		click_on('Search Flights')
		click_on('Choose Flight')
	end

  describe "new" do
  	it "should be accessible from flights_path" do
  		expect(current_path).to eq(new_booking_path)
  	end

  	it { should have_title("Odin Flight Booker") }
  	it { should have_selector("h1", text: "Enter Passenger Information") }
  	it { should have_text("From") }
  	it { should have_text("To") }
  	it { should have_text("Flight") }

  	it { should have_field("Name") }
  	it { should have_field("Email") }
  	it { should have_submit("Book Flight") }

  	describe "with no passenger information" do
  		it "does not book flight" do 
  			expect{click_on('Book Flight')}.not_to change{Booking.count}
  		end

  		it "displays error message" do
  			click_on('Book Flight')
  			expect(page).to have_text("error")
  		end
  	end

  	describe "with incomplete passenger information" do
  		before { fill_passenger_form(1) }

  		it "does not book flight" do 
  			expect{click_on('Book Flight')}.not_to change{Booking.count}
  		end

  		it "displays error message" do
  			click_on('Book Flight')
  			expect(page).to have_text("error")
  		end
  	end

  	describe "with complete passenger information" do
  		before { fill_passenger_form(2) }

  		it "books a flight" do 
  			expect{click_on('Book Flight')}.to change{Booking.count}.by(1)
  		end

  		it "displays success message" do
  			click_on('Book Flight')
  			expect(page).to have_css(".alert.alert-success")
  		end

  		it "associates new booking with chosen flight" do
  			flight_id = page.all('#flight_id').first.value
  			click_on('Book Flight')
  			expect(Booking.last.flight_id).to eq(flight_id.to_i)
  		end
  	end
  end 

  describe "show" do
    before do
      fill_passenger_form(2)
      click_on('Book Flight')
    end

    it { should have_title("Odin Flight Booker") }
    it { should have_selector("h1", text: "Booking Information") }
   
    it { should have_text("Booking Reference Number") }
    it { should have_text("Flight Information") }
    it { should have_text("Information for 2 Passengers") }
    it { should have_css(".alert.alert-success") }
    it { should have_link("Book Another Flight") }

  end
end
