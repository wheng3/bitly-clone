require "activerecord-import/base"
ActiveRecord::Import.require_adapter('postgresql')
require 'faker'

5.times do
	Url.create(long_url: 'http://'+Faker::Internet.domain_name)
end

urls = []
file = File.read('db/urls')
file.each_line do |line|
	urls<<Url.new(long_url: line[/\((.*)\)/,1])
end

urls.each do |url|
  url.run_callbacks(:create) { false }
end

Url.import urls