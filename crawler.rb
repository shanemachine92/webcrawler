require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'pry'
require_relative './document'
require_relative './data_structure'

class Crawler
	def initialize
		@doc = Document.new('http://dragonage.wikia.com')
		@document_array = DataStructure.new
	end

	def store_links
		@total_links = 0
		@doc.links.each do |link|
		  @document_array.arr.push(link)
		  @total_links += 1
		  puts link
		end
	end

	def get_next_link
		@next_link = @document_array.arr.shift
	end
end

Crawler.new.store_links
Crawler.new.crawl_links
