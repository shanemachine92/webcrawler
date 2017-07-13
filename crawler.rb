require 'nokogiri'
require 'open-uri'
require 'pry'

class Crawler
	attr_accessor :doc

	def initialize(url)
		# Fetch and parse HTML document
		@doc = Nokogiri::HTML(open(url))
	end

	def get_links(doc)
		puts "### Search for nodes by css"
		@doc.css('a').each do |link|
		  puts link.content
		end
	end
end


Crawler.new('http://dragonage.wikia.com/').get_links(@doc)
