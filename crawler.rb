require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'pry'
require_relative './document'
require_relative './document_collection'
require_relative './url_fetcher'
require 'set'

class Crawler
	def initialize(document_collection, url_collection)
		@document_collection = document_collection
		@url_collection = url_collection
		@set = Set.new
	end

	def done_crawling?
		@url_collection.empty?
	end

	def crawl_next_url
		url = @url_collection.next_url
		content = UrlFetcher.fetch(url)
		document = Document.new(url, content)
		@document_collection.add_document(document)
		puts document.domain_hrefs.take(5)
		document.domain_hrefs.each do |href|
			next if already_crawled?(href)
			@url_collection.add_url(href)
			track_url(href)
		end
		p "set size: #{@set.size}"
	end

	def already_crawled?(url)
		@set.include?(url)
	end

	def track_url(url)
		@set.add(url)
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
