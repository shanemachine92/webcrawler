require 'nokogiri'
require 'open-uri'
require 'pry'

class Document
	attr_accessor :doc, :links
	def initialize(url)
		# Fetch and parse HTML document
		@doc = Nokogiri::HTML(open(url))
		@links = @doc.css('a').map { |link| link['href'] }
	end
end

Document.new("http://dragonage.wikia.com")
