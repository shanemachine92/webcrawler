require 'open-uri'

module UrlFetcher
	class << self
		def fetch(url)
			open(url).read
		end
	end
end
