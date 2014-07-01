require 'spec_helper'

describe Passenger do
	let(:passenger) { create(:passenger) }
	subject { passenger }

	it { should be_valid }
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:passenger_bookings) }
	it { should respond_to(:bookings) }
	it { should respond_to(:flights) }

	describe "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:email) }
		it { should allow_value('foo@example.com').for(:email) }
		it { should_not allow_value('foo@example').for(:email) }
		it { should_not allow_value('@example.com').for(:email) }
	end

	describe "associations" do
		it { should have_many(:passenger_bookings).dependent(:destroy) }
		it { should have_many(:bookings) }
		it { should have_many(:flights) }
	end
end
