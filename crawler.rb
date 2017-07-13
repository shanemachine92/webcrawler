require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'pry'
require_relative './document'

class Crawler
	def initialize
		@document = Document.new('http://dragonage.wikia.com')
	end

	def get_links
		@document.doc.css('a').each do |link|
		  puts link.content
		end
	end
end

Crawler.new.get_links

