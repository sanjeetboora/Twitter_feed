class BotController < ApplicationController
	

	def index
		#!/usr/bin/env ruby
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = "maW9wJlB8jy1pWWLzkVKEoXc1"
			config.consumer_secret     = "OFEyHv3n4iG4zPj9VXHQ4Tfw7GJ8k2BTBjSKW4bbGkrrBgt5nl"
			config.access_token        = "913790032351133696-CTpRaT5wH5kJYVYfBqotoJOzym1pjnn"
			config.access_token_secret = "OaP2K90M2dC5DblZdOfa3sxROM2MSYKh7OhRoDWWW2zPc"
		end

		@feed = @client.search("#ruby").take(30)
	# client.update('Tweet from the command line!')
	counter=1
	respond_to do |format|
		format.html{
			counter=counter+1
			@feed = @client.search("#ruby").take(30)
		}
		format.js{

			offset = params["offset"]
			
			if offset
				offset = offset.to_i*counter
			else
				offset = 0
			end
		
			@new_offset = offset + 30
			@show_load_more = offset < @client.search("#ruby").count
			@arr = @client.search("#ruby").take(@new_offset)

			@feed = @arr.slice(@new_offset-30,@new_offset)
			
		}
		counter=counter+1
	end
end
end
