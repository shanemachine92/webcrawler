require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'pry'
require_relative './document'
require_relative './document_collection'
require_relative './url_fetcher'

class Crawler
	def initialize(document_collection, url_collection)
		@document_collection = document_collection
		@url_collection = url_collection
	end

	def done_crawling?
		@url_collection.empty?
	end

	def crawl_next_url
		url = @url_collection.next_url
		content = UrlFetcher.fetch(url)
		document = Document.new(url, content)
		@document_collection.add_document(document)
		puts document.hrefs.take(5)
		document.hrefs.each do |href|
			@url_collection.add_url(href)
		end
	end

	def run(times_to_run)
		times_to_run.times do
			if done_crawling? 
				puts "Crawling complete!"
				exit 0
			end
			crawl_next_url
		end
	end
end
