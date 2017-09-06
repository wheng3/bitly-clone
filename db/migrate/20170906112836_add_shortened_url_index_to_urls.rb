class AddShortenedUrlIndexToUrls < ActiveRecord::Migration[5.0]
	def change
		add_index :urls, :shortened_url, :unique => true
	end
end