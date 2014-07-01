FactoryGirl.define do
	factory :passenger do
		name  "John Doe"
		sequence(:email) { |n| "john#{n}@doe.com" }
	end
end
