require 'nokogiri'
require 'open-uri'
require 'pry'

class Document 
	attr_accessor :doc, :links
	def initialize(url)
		# Fetch and parse HTML document
		@doc = Nokogiri::HTML(open(url))
		@links = @doc.css('a')
	end
end
