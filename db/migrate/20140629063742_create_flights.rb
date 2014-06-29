class CreateFlights < ActiveRecord::Migration
	def change
		create_table :flights do |t|
			t.string     :flight_number
			t.datetime   :start_time
			t.integer    :duration
			t.references :from_airport
			t.references :to_airport

			t.timestamps
		end
	end
end
