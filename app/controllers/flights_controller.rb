class FlightsController < ApplicationController
	def index
		@airport_options = Airport.all.map do |airport|
			[airport.code, airport.id]
		end
		@passenger_options  = [1, 2, 3, 4]
		@dates = Flight.all_unique_future_flight_dates
		# Help maintain user's selection
		@from_selected = params[:from_airport_id]
		@to_selected   = params[:to_airport_id]
		@passenger_selected = params[:passengers]
		@date_selected = params[:flight_date]

		unless params[:from_airport_id].nil?
			if params[:from_airport_id] == params[:to_airport_id]
				flash.now[:error] = "Your 'From' and 'To' airports can't be the same"
			else
				@matched_flights = Flight.search_flights(params[:from_airport_id],
			                                           params[:to_airport_id],
			                                           params[:flight_date])
			end
		end
	end
end
