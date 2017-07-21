require 'nokogiri'
require 'open-uri'
require 'pry'

class DocumentCollection
	def initialize
		@arr = []
	end

	def add_document(document)
		@arr << document
	end

	def size
		@arr.size
	end
end
