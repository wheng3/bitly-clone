require 'faker'
5.times do
	Url.create(long_url: 'http://'+Faker::Internet.domain_name)
end