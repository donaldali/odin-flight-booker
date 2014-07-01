FactoryGirl.define do
	factory :booking do
	  sequence(:ref_number) { |n| "RN#{n}" }
  end
end
