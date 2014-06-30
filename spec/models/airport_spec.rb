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

		it { should validate_presence_of(:location) }
		it { should validate_presence_of(:code) }
		it { should ensure_length_of(:code).is_equal_to(3) }
	end

	describe "associations" do
		it { should have_many(:departing_flights).dependent(:destroy) }
		it { should have_many(:arriving_flights).dependent(:destroy) }
	end
end
