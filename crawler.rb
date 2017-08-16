require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'pry'
require_relative './document'
require_relative './document_collection'
require_relative './url_fetcher'
require 'set'


class Crawler
	attr_accessor :url, :href
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
		puts "set size: #{@set.size}"
		puts "url collection size: #{@url_collection.size}"
	end

	def already_crawled?(url)
		@set.include?(url)
	end

	def track_url(url)
		@set.add(url)
	end

	def run
		begin
			if done_crawling?
				puts "Crawling complete!"
				exit 0
			end
			crawl_next_url
		rescue OpenURI::HTTPError=>e
			puts "Error: #{e}"
		end
	end
end
