class BookingsController < ApplicationController

	def new
		@booking = Booking.new
		@flight  = Flight.find(params[:flight_id])
		params[:passengers].to_i.times { @booking.passengers.build }
	end

	def create
		@booking = Booking.new(booking_params)

		if @booking.save
			@booking.update_attribute(:flight_id, params[:flight_id])
			send_thank_you_emails(@booking.passengers)
			
			flash[:success] = "Your flight was succesfully booked!"
			redirect_to @booking
		else
			@flight  = Flight.find(params[:flight_id])
			render 'new'
		end
	end

	def show
		@booking = Booking.find(params[:id])
	end

	private

	  def booking_params
	  	params.require(:booking).permit(passengers_attributes: [:id, :name, :email])
	  end

	  def send_thank_you_emails(passengers)
	  	passengers.each do |passenger|
	  		PassengerMailer.thank_you_email(passenger).deliver
	  	end
	  end
end
