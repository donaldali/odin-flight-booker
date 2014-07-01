class CreateBookings < ActiveRecord::Migration
	def change
		create_table :bookings do |t|
			t.string     :ref_number
			t.references :flight

			t.timestamps
		end
		
		add_index :bookings, :ref_number
	end
end
