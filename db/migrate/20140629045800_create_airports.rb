class CreateAirports < ActiveRecord::Migration
	def change
		create_table :airports do |t|
			t.string :code
			t.string :location

			t.timestamps
		end

		add_index :airports, :code
	end
end
