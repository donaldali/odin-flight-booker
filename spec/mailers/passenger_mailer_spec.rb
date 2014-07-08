require "spec_helper"

describe PassengerMailer do

	describe '#thank_you_email' do
		let(:passenger) { create(:passenger) }
		let(:booking)   { create(:booking) }
		let(:flight)    { create(:flight) }
		let(:mail)      { PassengerMailer.thank_you_email(passenger) }

		before do
			# booking.flight_id = flight.id
			booking.update_attribute(:flight_id, flight.id)
			booking.passengers << passenger
		end

		it 'has correct subject' do
			expect(mail.subject).to eq('Thank you for your flight booking')
		end

		it 'has correct receiver' do
			expect(mail.to).to eq([passenger.email])
		end

		it 'has correct sender' do
			expect(mail.from).to eq(['noreply@odinflightbooker.com'])
		end

		it 'has correct content' do
			expect(mail.body.encoded).to match(passenger.name)
		end

		it 'delievers email' do
			expect{mail.deliver}.to change{ActionMailer::Base.deliveries.count}.by(1)
		end
	end
end
