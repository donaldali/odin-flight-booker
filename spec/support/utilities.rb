include ApplicationHelper

def fill_search_form
	visit flights_path
	select('SFO', from: 'From', match: :first)
	select('NYC', from: 'To', match: :first)
	select('2', from: 'Passengers')
	select(next_day, from: 'Flight date')
end

def next_day
	Time.now.utc.tomorrow.strftime('%d/%m/%Y')
end
