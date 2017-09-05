get '/' do
	@urls = Url.order(id: :desc)
	erb :"static/index", :locals => {:flash => @flash}
end

post '/urls' do
	own_website = false

	if (params[:long_url]).include?("#{request.base_url}/")
		own_website = true
		short_portion_of_url = (params[:long_url]).gsub("#{request.base_url}/",'')
		url = Url.find_by(shortened_url: short_portion_of_url)
	else
		url = Url.find_by(long_url: params[:long_url])
	end

	if (!url.nil?)
		@flash = "#{url.long_url} has already been added"
		redirect '/'
	else
		if(own_website)
			@flash = "No such shortened link exists"
			redirect '/'
		else
			@url = Url.new(long_url: params[:long_url])
			if @url.save
				@url.to_json
			else
				@flash = "Failed to add url. Please make sure you include 'http://' or 'https://'"
				redirect '/'
			end
		end
	end
end

get '/:short_url' do
	url = Url.find_by(shortened_url: params[:short_url])
	if !url.nil?
		url.click_count += 1
		url.save
		redirect "#{url.long_url}"
	else
		redirect '/'
	end
end




# get post put patch